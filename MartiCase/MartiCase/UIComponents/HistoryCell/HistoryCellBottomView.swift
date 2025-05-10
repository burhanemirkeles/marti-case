//
//  HistoryCellBottomView.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit

public struct HistoryCellBottomViewItem {
  let startingPoint: TopTitleBottomDetailLabelViewItem
  let endingPoint: TopTitleBottomDetailLabelViewItem
}

public final class HistoryCellBottomView: UIView {
  // MARK: - Subviews -
  private var startingInfoView = TopTitleBottomDetailLabelView()
  private var endingInfoView = TopTitleBottomDetailLabelView()
  private var item: HistoryCellBottomViewItem?

  public init() {
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with item: HistoryCellBottomViewItem) {
    self.item = item
    setupView()
    setConstraints()
  }

  private func setupView() {
    guard let item else { return }
    startingInfoView.configure(
      with: TopTitleBottomDetailLabelViewItem(
        title: item.startingPoint.title,
        detail: item.startingPoint.detail
      )
    )
    endingInfoView.configure(
      with: TopTitleBottomDetailLabelViewItem(
        title: item.endingPoint.title,
        detail: item.endingPoint.detail
      )
    )
    startingInfoView.translatesAutoresizingMaskIntoConstraints = false
    endingInfoView.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setConstraints() {
    addSubview(startingInfoView)
    addSubview(endingInfoView)

    NSLayoutConstraint.activate([
      startingInfoView.topAnchor.constraint(equalTo: topAnchor),
      startingInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
      startingInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
      startingInfoView.heightAnchor.constraint(equalToConstant: 42),

      endingInfoView.topAnchor.constraint(equalTo: startingInfoView.bottomAnchor, constant: 24),
      endingInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
      endingInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
      endingInfoView.heightAnchor.constraint(equalToConstant: 42),

      endingInfoView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
