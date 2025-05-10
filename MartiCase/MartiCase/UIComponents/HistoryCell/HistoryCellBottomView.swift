//
//  HistoryCellBottomView.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit
import SnapKit

public struct HistoryCellBottomViewItem {
  let startingPoint: TopTitleBottomDetailLabelViewItem
  let endingPoint: TopTitleBottomDetailLabelViewItem
}

public final class HistoryCellBottomView: UIView {
  // MARK: - Subviews -
  private var startingInfoView = TopTitleBottomDetailLabelView()
  private var endingInfoView = TopTitleBottomDetailLabelView()
  private var imageView = UIImageView()
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

    startingInfoView.configure(with: item.startingPoint)
    endingInfoView.configure(with: item.endingPoint)

    imageView.image = .fromTo
    imageView.tintColor = .gray
    imageView.contentMode = .scaleAspectFit

    addSubview(startingInfoView)
    addSubview(endingInfoView)
    addSubview(imageView)
  }

  private func setConstraints() {
    startingInfoView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.leading.equalToSuperview().offset(40)
      $0.trailing.equalToSuperview().offset(-12)
    }

    endingInfoView.snp.makeConstraints {
      $0.top.equalTo(startingInfoView.snp.bottom).offset(24)
      $0.leading.equalToSuperview().offset(40)
      $0.trailing.equalToSuperview().offset(-12)
      $0.bottom.equalToSuperview().offset(-8)
    }

    imageView.snp.makeConstraints {
      $0.top.equalTo(startingInfoView.snp.centerY)
      $0.leading.equalToSuperview().offset(8)
      $0.centerY.equalTo(startingInfoView.snp.bottom).offset(12)
      $0.bottom.equalTo(endingInfoView.snp.centerY)
    }
  }
}
