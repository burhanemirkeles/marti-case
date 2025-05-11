//
//  MainViewController.swift
//  MartiCase
//
//  Created by Emir Keleş on 8.05.2025.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
  var bottomBar = BottomBar()
  var mapView = MKMapView()
  private let viewModel = MainViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupBottomBar()
    setupMapView()
    viewModel.requestPermissions()
    bindViewModel()
  }

  private func setupMapView() {
    mapView.translatesAutoresizingMaskIntoConstraints = false
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    mapView.isZoomEnabled = true
    mapView.delegate = self
    view.addSubview(mapView)

    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  private func setupBottomBar() {
    view.addSubview(bottomBar)
    bottomBar.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomBar.heightAnchor.constraint(equalToConstant: 80)
    ])

    bottomBar.onLeftButtonTapped = { [weak self] in
      let routeHistoryVC = RouteHistoryViewController()
      let navVC = UINavigationController(rootViewController: routeHistoryVC)
      navVC.modalPresentationStyle = .fullScreen
      self?.present(navVC, animated: true)
    }
  }

  private func bindViewModel() {
    viewModel.onLocationUpdate = { [weak self] point in
      guard let self = self else { return }
      self.addMarker(for: point)

      let points = self.viewModel.trackedPoints
      if points.count >= 2 {
        let from = points[points.count - 2].location.coordinate
        let to = points[points.count - 1].location.coordinate
        self.drawRoute(from: from, to: to)
      }
    }

    bottomBar.onCenterButtonTapped = { [weak self] in
      self?.viewModel.toggleTracking()
      let locationPoint = LocationPoint(location: self?.viewModel.currentLocation ?? CLLocation(), timestamp: Date())
      self?.addMarker(for: locationPoint)
    }

    viewModel.onTrackingStatusChanged = { [weak self] isTracking in
      DispatchQueue.main.async {
        self?.bottomBar.updateCenterButtonTitle(isTracking: isTracking)
        self?.viewDidLayoutSubviews()
      }
    }

    viewModel.onRecordingFinished = { [weak self] messsage in
      let alertVC = CustomAlertViewController(title: "title", message: messsage, preferredStyle: .alert)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve

      alertVC.doneButtonAction = {[weak self] in
      self?.viewModel.getRouteHistoryItem(from: self?.viewModel.trackedPoints ?? []) { route in
          guard let route else { return }
          CoreDataHelper.shared.saveRoute(for: route)
        }

        let routess = CoreDataHelper.shared.fetchRoutes()
        print(routess)
      }

      self?.present(alertVC, animated: true)
      guard let annotations = self?.mapView.annotations else { return }
      self?.mapView.removeAnnotations(annotations)
    }
  }

  private func addMarker(for point: LocationPoint) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = point.location.coordinate
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    annotation.title = "Moved to new point"
    annotation.subtitle = "Time: \(formatter.string(from: point.timestamp))"
    mapView.addAnnotation(annotation)
  }

  private func drawRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
    let sourcePlacemark = MKPlacemark(coordinate: source)
    let destinationPlacemark = MKPlacemark(coordinate: destination)

    let directionRequest = MKDirections.Request()
    directionRequest.source = MKMapItem(placemark: sourcePlacemark)
    directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
    directionRequest.transportType = .walking

    let directions = MKDirections(request: directionRequest)
    directions.calculate { [weak self] response, error in
      guard let self = self, let route = response?.routes.first, error == nil else {
        print("Failed to get route: \(error?.localizedDescription ?? "Unknown error")")
        return
      }
      self.mapView.addOverlay(route.polyline)
    }
  }
}

extension MainViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if let polyline = overlay as? MKPolyline {
      let renderer = MKPolylineRenderer(overlay: polyline)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 3
      return renderer
    }
    return MKOverlayRenderer(overlay: overlay)
  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else { return nil }

    let identifier = "marker"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

    if annotationView == nil {
      annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
    } else {
      annotationView?.annotation = annotation
    }
    return annotationView
  }
}
