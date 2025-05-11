//
//  CoreDataHelper.swift
//  MartiCase
//
//  Created by Emir Keleş on 11.05.2025.
//

import CoreData
import UIKit

public class CoreDataHelper {
  static let shared = CoreDataHelper()
  // swiftlint: disable force_cast
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  // swiftlint: enable force_cast
  public func saveRoute(for item: SavingRouteModel) {
    let route = SavedRoute(context: context)
    route.title = item.title
    route.date = item.date
    route.startingPointTitle = item.startingPointData.title
    route.startinPointDetail = item.startingPointData.detail
    route.endingPointTitle = item.endingPointData.title
    route.endingPointDetail = item.endingPointData.detail

    do {
      try context.save()
    } catch {
      print("Failed to save route: \(error)")
    }
  }

  func fetchRoutes() -> [SavedRoute] {
    let request: NSFetchRequest<SavedRoute> = SavedRoute.fetchRequest()
    return (try? context.fetch(request)) ?? []
  }
}
