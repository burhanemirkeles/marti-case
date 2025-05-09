//
//  RouteHistoryViewModel.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

final class RouteHistoryViewModel {
  private(set) var routes: [String] = []

  init() {
    loadDummyRoutes()
  }

  private func loadDummyRoutes() {
    routes = [
      "Sabah Yürüyüşü - 08:00",
      "Akşam Koşusu - 18:30",
      "Köpek Gezdirme - Yesterday",
    ]
  }

  func numberOfRows() -> Int {
    return routes.count
  }

  func routeTitle(at index: Int) -> String {
    return routes[index]
  }
}
