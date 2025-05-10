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
      guard let location = locationManager.location else { return }
      trackedPoints.append(LocationPoint(location: location, timestamp: Date()))
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
    onRecordingFinished?("tracking points message")
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if isTracking {
      guard let lastLocation = locations.last else { return }

      let newPoint = LocationPoint(
        location: lastLocation,
        timestamp: Date()
      )
      trackedPoints.append(newPoint)
      onLocationUpdate?(newPoint)
    }
    currentLocation = locations.last
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      startTracking()
    }
  }
}
