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
  private(set) var trackedPoints: [LocationPoint] = []
  var onLocationUpdate: ((LocationPoint) -> Void)?

  override init() {
    super.init()
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
    locationManager.startUpdatingLocation()
  }

  func stopTracking() {
    locationManager.stopUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastLocation = locations.last else { return }

    let newPoint = LocationPoint(
      coordinate: lastLocation.coordinate,
      timestamp: Date()
    )

    trackedPoints.append(newPoint)
    onLocationUpdate?(newPoint)
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways || status == .authorizedWhenInUse {
      startTracking()
    }
  }
}
