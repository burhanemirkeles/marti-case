//
//  CustomAlertViewController.swift
//  MartiCase
//
//  Created by Emir Keleş on 11.05.2025.
//

import UIKit

public final class CustomAlertViewController: UIAlertController {
  private var iconView = UIImageView()
  private var titleLabel = UILabel()
  private var descriptionLabel = UILabel()

  private var buttonsStackView = UIStackView()
  private var cancelButton = UIButton()
  private var doneButton = UIButton()
  public var doneButtonAction: (() -> Void)?

  private let alertView = UIView()

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setConstraints()
    configureView(with: "")
  }

  private func configureView(with item: String) {
    iconView.image = .popUpIcon
    iconView.tintColor = .systemBlue
    iconView.contentMode = .scaleAspectFit

    titleLabel.text = title
    titleLabel.font = .boldSystemFont(ofSize: 22)
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    descriptionLabel.text = message
    descriptionLabel.font = .systemFont(ofSize: 16)
    descriptionLabel.textColor = .darkGray
    descriptionLabel.textAlignment = .center
    descriptionLabel.numberOfLines = 0

    buttonsStackView.axis = .horizontal
    buttonsStackView.distribution = .fillEqually
    buttonsStackView.spacing = 12

    cancelButton.setTitle("No", for: .normal)
    cancelButton.setTitleColor(.systemBlue, for: .normal)
    cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    cancelButton.backgroundColor = .gray.withAlphaComponent(0.1)
    cancelButton.layer.cornerRadius = 12
    cancelButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)

    doneButton.setTitle("Yes", for: .normal)
    doneButton.setTitleColor(.white, for: .normal)
    doneButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    doneButton.backgroundColor = .systemBlue
    doneButton.layer.cornerRadius = 12
    doneButton.addTarget(self, action: #selector(saveRoute), for: .touchUpInside)
  }

  private func setupViews() {
    alertView.backgroundColor = .white
    alertView.layer.cornerRadius = 16

    view.addSubview(alertView)
    alertView.addSubview(iconView)
    alertView.addSubview(titleLabel)
    alertView.addSubview(descriptionLabel)
    alertView.addSubview(buttonsStackView)
    buttonsStackView.addArrangedSubview(cancelButton)
    buttonsStackView.addArrangedSubview(doneButton)

    alertView.bringSubviewToFront(doneButton)
  }

  private func setConstraints() {
    alertView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalTo(300)
      $0.top.bottom.equalToSuperview()
    }

    iconView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(24)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().inset(16)
      $0.height.equalTo(75)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(iconView.snp.bottom).offset(16)
      $0.leading.trailing.equalToSuperview().inset(16)
    }

    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview().inset(16)
    }

    buttonsStackView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(24)
      $0.height.equalTo(44)
      $0.bottom.equalToSuperview().inset(16)
    }
  }

  @objc
  private func dismissAlert() {
    self.dismiss(animated: true)
  }

  @objc
  private func saveRoute() {
    self.dismiss(animated: true)
    self.doneButtonAction?()
  }
}
