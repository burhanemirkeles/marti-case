//
//  RouteHistoryViewModel.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit
import CoreData

final class RouteHistoryViewModel {
  private(set) var routes: [SavedRoute] = []

  func loadRoutes(completion: @escaping () -> Void) {
    // swiftlint: disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint: enable force_cast
    let fetchRequest: NSFetchRequest<SavedRoute> = SavedRoute.fetchRequest()

    do {
      let savedRoutes = try context.fetch(fetchRequest)
      self.routes = savedRoutes
      completion()
    } catch {
      print("Failed to fetch routes: \(error)")
    }
  }
}
