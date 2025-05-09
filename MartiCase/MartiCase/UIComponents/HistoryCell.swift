//
//  HistoryCell.swift
//  MartiCase
//
//  Created by Emir Keleş on 10.05.2025.
//

import UIKit

class HistoryCell: UITableViewCell {
  static let identifier = "HistoryCell"

  func configure(with title: String) {
    textLabel?.text = title
    textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
  }
}
