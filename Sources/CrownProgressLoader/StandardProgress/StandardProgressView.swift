//
//  StandardProgressView.swift
//  
//
//  Created by Aman Joshi on 25/05/21.
//

import UIKit

public class StandardProgressView: UIView {

  let width:CGFloat = 110

  private var message:String {
    didSet {
      self.titleLabel.text = message
    }
  }

  private let progressLoader: CircularProgressView = {
    let progress = CircularProgressView(colors: [.red, .systemGreen, .systemBlue,.systemYellow], lineWidth: 4, width:40)
    return progress
  }()

  private lazy var titleLabel:UILabel = {
    let label = UILabel()
    label.text = message
    label.textColor = .black
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  public init(frame: CGRect, message:String = "Loading...") {
    self.message = message
    super.init(frame: frame)
  }

  public convenience init(message:String = "Loading...") {
    self.init(frame: .zero)
    self.message = message
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 10.0

    self.show(progressLoader)
    self.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 10)
    ])

    self.applyShadow()
  }

  private func applyShadow() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 8, height: 8)
    self.layer.shadowRadius = 5.0
    self.layer.shadowOpacity = 0.3
  }

}
