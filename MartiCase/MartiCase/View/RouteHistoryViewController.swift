//
//  RouteHistoryViewController.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit

final class RouteHistoryViewController: UIViewController {

  private let viewModel = RouteHistoryViewModel()
  private let tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()

    viewModel.loadRoutes {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  private func setupView() {
    title = "Route History"
    view.backgroundColor = .white

    navigationItem.title = "Route History"
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .close,
      target: self,
      action: #selector(dismissSelf)
    )

    tableView.register(RouteHistoryCell.self, forCellReuseIdentifier: RouteHistoryCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
    tableView.bounces = false

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  @objc
  private func dismissSelf() {
    dismiss(animated: true)
  }
}

extension RouteHistoryViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.routes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: RouteHistoryCell.identifier,
      for: indexPath
    ) as? RouteHistoryCell else {
      return UITableViewCell()
    }
    let route = viewModel.routes[indexPath.row]
    cell.configure(
      with: SavingRouteModel(
        title: route.title ?? "",
        date: Date(),
        startingPointData: TopTitleBottomDetailLabelViewItem(
          title: route.startingPointTitle ?? "",
          detail: route.startinPointDetail ?? ""
        ), endingPointData: TopTitleBottomDetailLabelViewItem(
          title: route.endingPointTitle ?? "", detail: route.endingPointDetail ?? ""
        )
      )
    )
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // navigate to route detail if needed
  }
}
