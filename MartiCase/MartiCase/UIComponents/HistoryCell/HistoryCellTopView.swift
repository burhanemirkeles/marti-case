//
//  HistoryCellTopView.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit

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

    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
      imageView.widthAnchor.constraint(equalToConstant: 40),
      imageView.heightAnchor.constraint(equalToConstant: 40),

      titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 18),
      titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
    ])
  }
}
