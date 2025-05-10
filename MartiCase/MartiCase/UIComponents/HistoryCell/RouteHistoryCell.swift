//
//  RouteHistoryCell.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit

public struct RouteHistoryCellItem {
  let title: String
}

class RouteHistoryCell: UITableViewCell {
  static let identifier = "RouteHistoryCell"
  var item: RouteHistoryCellItem?

  // MARK: - Subviews -
  let topView = HistoryCellTopView()
  let bottomView = HistoryCellBottomView()

  func configure(with item: RouteHistoryCellItem) {
    self.item = item

    topView.configure(with: HistoryCellTopViewItem(title: item.title))

    bottomView.configure(
      with: HistoryCellBottomViewItem(
        startingPoint: TopTitleBottomDetailLabelViewItem(
          title: "Şair Nedim Cad 43",
          detail: "Beşiktaş İstanbul"
        ), endingPoint: TopTitleBottomDetailLabelViewItem(
          title: "Ihlamurdere Cad 21",
          detail: "Beşiktaş İstanbul")
      )
    )
    topView.translatesAutoresizingMaskIntoConstraints = false
    bottomView.translatesAutoresizingMaskIntoConstraints = false

    setConstraints()
  }

  private func setConstraints() {
    addSubview(topView)
    addSubview(bottomView)

    NSLayoutConstraint.activate([
      topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

      bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 12),
      bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
  }
}
