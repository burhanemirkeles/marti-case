//
//  RouteHistoryCell.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit
import SnapKit

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

    topView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }

    bottomView.snp.makeConstraints {
      $0.top.equalTo(topView.snp.bottom).offset(12)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    layoutIfNeeded()
  }
}
