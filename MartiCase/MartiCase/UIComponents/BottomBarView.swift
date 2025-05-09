//
//  BottomBarView.swift
//  MartiCase
//
//  Created by Emir Keleş on 9.05.2025.
//

import UIKit

public final class BottomBar: UIView {
  // MARK: - Subviews -
  private var leftButton = UIButton()
  private var centerButton = UIButton()
  private var rightButton = UIButton()
  public var onLeftButtonTapped: (() -> Void)?
  public var onCenterButtonTapped: (() -> Void)?

  init() {
    super.init(frame: .zero)
    setupView()
    configureButton()
    setConstraints()
  }

  private func setupView() {
    backgroundColor = .white
    layer.shadowColor = UIColor.black.cgColor
    layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    clipsToBounds = false
    layer.shadowOpacity = 0.25
    layer.shadowOffset = CGSize(width: 0, height: -6)
    layer.shadowRadius = 3
  }
  private func configureButton() {
    leftButton.setImage(UIImage(systemName: "calendar"), for: .normal)
    leftButton.tintColor = .black
    leftButton.backgroundColor = .white
    leftButton.layer.cornerRadius = 25
    leftButton.layer.borderWidth = 1
    leftButton.layer.borderColor = UIColor.lightGray.cgColor
    leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)

    centerButton.setTitle("Go Offline", for: .normal)
    centerButton.setTitleColor(.white, for: .normal)
    centerButton.backgroundColor = .systemBlue
    centerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    centerButton.layer.cornerRadius = 20
    centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)

    rightButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
    rightButton.tintColor = .black
    rightButton.backgroundColor = .white
    rightButton.layer.cornerRadius = 25
    rightButton.layer.borderWidth = 1
    rightButton.layer.borderColor = UIColor.lightGray.cgColor
  }

  private func setConstraints() {
    let stackView = UIStackView(arrangedSubviews: [leftButton, centerButton, rightButton])
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalCentering
    stackView.spacing = 16

    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    leftButton.translatesAutoresizingMaskIntoConstraints = false
    rightButton.translatesAutoresizingMaskIntoConstraints = false
    centerButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
      leftButton.widthAnchor.constraint(equalToConstant: 50),
      leftButton.heightAnchor.constraint(equalToConstant: 50),
      rightButton.widthAnchor.constraint(equalToConstant: 50),
      rightButton.heightAnchor.constraint(equalToConstant: 50),
      centerButton.heightAnchor.constraint(equalToConstant: 40),
      centerButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120)
    ])
  }

  @objc
  func leftButtonTapped() {
    onLeftButtonTapped?()
  }

  @objc
  func centerButtonTapped() {
    onCenterButtonTapped?()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
