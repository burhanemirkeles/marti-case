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
  public func saveRoute(item: String) {
    let route = SavedRoute(context: context)
    route.title = item

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
