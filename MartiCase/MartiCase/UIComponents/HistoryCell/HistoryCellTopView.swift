//
//  HistoryCellTopView.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit
import SnapKit

public struct HistoryCellTopViewItem {
  public var title: String
}

public final class HistoryCellTopView: UIView {
  // MARK: - Subviews -
  private var imageView = UIImageView()
  private var titleLabel = UILabel()
  private var item: HistoryCellTopViewItem?

  public init() {
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with item: HistoryCellTopViewItem) {
    self.item = item
    setupView()
    setConstraints()
  }

  private func setupView() {
    backgroundColor = .white
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = .routeIcon

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 1
    titleLabel.text = item?.title
    titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
  }

  private func setConstraints() {
    addSubview(imageView)
    addSubview(titleLabel)

    imageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(18)
      $0.height.width.equalTo(40)
      $0.top.equalToSuperview().offset(12)
      $0.bottom.equalToSuperview().offset(-12)
    }

    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(imageView.snp.trailing).offset(18)
      $0.trailing.equalToSuperview().offset(-18)
      $0.centerY.equalTo(imageView.snp.centerY)
      $0.top.equalToSuperview().offset(12)
      $0.bottom.equalToSuperview().offset(-12)
    }
    layoutIfNeeded()
  }
}
