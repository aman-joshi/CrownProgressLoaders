//
//  ProgressView.swift
//  
//
//  Created by Aman Joshi on 25/05/21.
//

import UIKit

public class ProgressView: UIView {

  let colors: [UIColor]
  let lineWidth: CGFloat

  private lazy var shapeLayer: ProgressShapeLayer = {
    return ProgressShapeLayer(strokeColor: colors[1], lineWidth: lineWidth)
  }()

  public init(frame:CGRect, colors:[UIColor], lineWidth:CGFloat) {
    self.colors = colors
    self.lineWidth = lineWidth
    super.init(frame: frame)
    self.backgroundColor = .clear
  }


  public convenience init(colors: [UIColor], lineWidth: CGFloat) {
    self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
  }


  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.frame.width / 2

    // create an oval path
    let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))

    shapeLayer.path = path.cgPath
  }
}

extension ProgressView {

  // MARK: - Animations
  func animateStroke() {

    let startAnimation = StrokeAnimation(
      type: .start,
      beginTime: 0.25,
      fromValue: 0.0,
      toValue: 1.0,
      duration: 0.75)

    let endAnimation = StrokeAnimation(
      type: .end,
      fromValue: 0.0,
      toValue: 1.0,
      duration: 0.75)

    let strokeAnimationGroup = CAAnimationGroup()
    strokeAnimationGroup.duration = 1
    strokeAnimationGroup.repeatCount = .infinity
    strokeAnimationGroup.animations = [startAnimation,endAnimation]

    shapeLayer.add(strokeAnimationGroup, forKey: nil)

    let colorAnimation = StrokeColorAnimation(
      colors: colors.map { $0.cgColor },
      duration: strokeAnimationGroup.duration * Double(colors.count)
    )

    shapeLayer.add(colorAnimation, forKey: nil)

    self.layer.addSublayer(shapeLayer)

  }

  func animateRotation() {
    let rotationAnimation = RotationAnimation(
      direction: .z,
      fromValue: 0,
      toValue: CGFloat.pi * 2,
      duration: 2,
      repeatCount: .greatestFiniteMagnitude
    )

    self.layer.add(rotationAnimation, forKey: nil)
  }

}

extension UIView {

  public func show(_ view:ProgressView) {
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      view.widthAnchor.constraint(equalToConstant: 60),
      view.heightAnchor.constraint(equalTo: view.widthAnchor)
    ])
    view.animateStroke()
    view.animateRotation()
  }

  public func stop(_ view:ProgressView) {
    if self.subviews.contains(view) {
      for subview in self.subviews {
        if let progressView = subview as? ProgressView {
          progressView.removeFromSuperview()
          return
        }
      }
    }
  }
}
