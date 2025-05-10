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
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: RouteHistoryCell.identifier,
      for: indexPath
    ) as? RouteHistoryCell else {
      return UITableViewCell()
    }
    cell.configure(with: RouteHistoryCellItem(title: "10/05/2025 | Beşiktaş"))
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // navigate to route detail if needed
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    350
  }
}
