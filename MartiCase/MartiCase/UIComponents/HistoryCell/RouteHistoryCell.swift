//
//  RouteHistoryCell.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit
import SnapKit

class RouteHistoryCell: UITableViewCell {
  static let identifier = "RouteHistoryCell"
  var item: SavingRouteModel?

  // MARK: - Subviews -
  let topView = HistoryCellTopView()
  let bottomView = HistoryCellBottomView()

  func configure(with item: SavingRouteModel) {
    self.item = item

    topView.configure(with: HistoryCellTopViewItem(title: item.title))

    bottomView.configure(
      with: HistoryCellBottomViewItem(
        startingPoint: TopTitleBottomDetailLabelViewItem(
          title: item.startingPointData.title,
          detail: item.startingPointData.detail
        ), endingPoint: TopTitleBottomDetailLabelViewItem(
          title: item.endingPointData.title,
          detail: item.endingPointData.detail
        )
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
