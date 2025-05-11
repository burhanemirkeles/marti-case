//
//  MainViewModel.swift
//  MartiCase
//
//  Created by Emir Keleş on 9.05.2025.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()
  public var currentLocation: CLLocation?
  private(set) var trackedPoints: [LocationPoint] = []

  var onLocationUpdate: ((LocationPoint) -> Void)?
  var onTrackingStatusChanged: ((Bool) -> Void)?
  var onRecordingFinished: ((String) -> Void)?

  var isTracking: Bool = false {
    didSet {
      onTrackingStatusChanged?(isTracking)
    }
  }

  func toggleTracking() {
    isTracking.toggle()

    if isTracking {
      startTracking()
      if trackedPoints.isEmpty {
        guard let location = locationManager.location else { return }
        trackedPoints.append(LocationPoint(location: location, timestamp: Date()))
      }

    } else {
      stopTracking()
    }
  }

  override init() {
    super.init()
    locationManager.delegate = self
    configureLocationManager()
  }

  private func configureLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 100
    locationManager.pausesLocationUpdatesAutomatically = false
  }

  func requestPermissions() {
    locationManager.requestAlwaysAuthorization()
  }

  func startTracking() {
    trackedPoints = []
    locationManager.startUpdatingLocation()
  }

  func stopTracking() {
    locationManager.stopUpdatingLocation()
    onRecordingFinished?("Do you want to save your route?")
  }

  func getRouteHistoryItem(from locations: [LocationPoint], completion: @escaping (SavingRouteModel?) -> Void) {
    guard let startLocation = locations.first?.location, let endLocation = locations.last?.location else {
      completion(nil)
      return
    }

    var title: String = ""
    var startingPointTitle: String = ""
    var startingPointDetail: String = ""
    var endingPointTitle: String = ""
    var endingPointDetail: String = ""

    let group = DispatchGroup()

    group.enter()
    startLocation.reverseGeocode { placemark in
      let city = placemark?.locality ?? "Unknown City"
      let date = startLocation.timestamp
      let dateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
      title = "\(dateString) | \(city)"

      let dateStringForDetail = DateFormatter.localizedString(
        from: startLocation.timestamp,
        dateStyle: .none,
        timeStyle: .short
      )

      startingPointTitle = placemark?.name ?? "Unknown Place"
      startingPointDetail = "\(placemark?.locality ?? "Unknown Locality"), \(dateStringForDetail)"
      group.leave()
    }

    group.enter()
    endLocation.reverseGeocode { placemark in
      let dateStringForDetail = DateFormatter.localizedString(
        from: endLocation.timestamp,
        dateStyle: .none,
        timeStyle: .short
      )
      endingPointTitle = placemark?.name ?? "Unknown Place"
      endingPointDetail = "\(placemark?.locality ?? "Unknown Locality"), \(dateStringForDetail)"
      group.leave()
    }

    group.notify(queue: .main) {
      let item = SavingRouteModel(
        title: title,
        date: startLocation.timestamp,
        startingPointData: TopTitleBottomDetailLabelViewItem(
          title: startingPointTitle,
          detail: startingPointDetail
        ),
        endingPointData: TopTitleBottomDetailLabelViewItem(
          title: endingPointTitle,
          detail: endingPointDetail
        )
      )
      completion(item)
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if isTracking {
      guard let lastLocation = locations.last else { return }

      let newPoint = LocationPoint(
        location: lastLocation,
        timestamp: lastLocation.timestamp
      )
      trackedPoints.append(newPoint)
      onLocationUpdate?(newPoint)
    }
    currentLocation = locations.last
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch manager.authorizationStatus {
    case .authorizedAlways:
      manager.allowsBackgroundLocationUpdates = true
      startTracking()
    default:
      manager.allowsBackgroundLocationUpdates = false
    }
  }
}

extension CLLocation {
  func reverseGeocode(completion: @escaping (CLPlacemark?) -> Void) {
    CLGeocoder().reverseGeocodeLocation(self) { placemarks, _ in
      completion(placemarks?.first)
    }
  }
}
