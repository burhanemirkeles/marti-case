//
//  ViewController.swift
//  MartiCase
//
//  Created by Emir Keleş on 8.05.2025.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

  var bottomBar = BottomBar()
  var mapView = MKMapView()
  private let viewModel = ViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupBottomBar()
    setupMapView()
    viewModel.requestPermissions()
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
  }
}
