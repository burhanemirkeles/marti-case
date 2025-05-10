//
//  TopTitleBottomDetailLabelView.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit
import SnapKit

public struct TopTitleBottomDetailLabelViewItem {
  public var title: String
  public var detail: String
}

public final class TopTitleBottomDetailLabelView: UIView {
  // MARK: - Subviews -
  //  private var stackView = UIStackView()
  private var titleLabel = UILabel()
  private var detailLabel = UILabel()

  private var item: TopTitleBottomDetailLabelViewItem?

  public init() {
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with item: TopTitleBottomDetailLabelViewItem) {
    self.item = item
    setupView()
    setConstraints()
  }

  private func setupView() {
    titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
    titleLabel.textColor = .label
    titleLabel.text = item?.title

    detailLabel.font = .systemFont(ofSize: 17, weight: .thin)
    detailLabel.textColor = .secondaryLabel
    detailLabel.text = item?.detail

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setConstraints() {
    addSubview(titleLabel)
    addSubview(detailLabel)

    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview()
    }

    detailLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-8)
    }
    layoutIfNeeded()
  }
}
