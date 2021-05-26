//
//  ReplicatorProgressView.swift
//  
//
//  Created by Aman Joshi on 25/05/21.
//

import UIKit

public class ReplicatorProgressView: UIView {


  let lengthMultiplier: CGFloat = 3.0
  let replicatorLayer = CAReplicatorLayer()
  let instanceLayer = CALayer()
  let fadeAnimation = CABasicAnimation(keyPath: "opacity")
  let width:CGFloat = 160.0


  public override init(frame:CGRect) {
    super.init(frame: frame)
  }

  public convenience init() {
    self.init(frame:.zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    setUpInstanceLayer()
    setUpReplicatorLayer()
    setUpLayerFadeAnimation()
  }

}

extension ReplicatorProgressView {

  // MARK: - Layer setup
  func setUpReplicatorLayer() {
    replicatorLayer.frame = self.bounds
    let count:CGFloat = 12.0
    replicatorLayer.instanceCount = Int(count)
    replicatorLayer.instanceDelay = CFTimeInterval(1.0 / count)
    replicatorLayer.instanceColor = UIColor.white.cgColor
    replicatorLayer.instanceRedOffset = 0.0
    replicatorLayer.instanceGreenOffset = -0.05
    replicatorLayer.instanceBlueOffset = -0.05
    replicatorLayer.instanceAlphaOffset = 0.0

    let angle = Float.pi * 2.0 / Float(count)
    replicatorLayer.instanceTransform =
      CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)

    self.layer.addSublayer(replicatorLayer)
  }

  func setUpInstanceLayer() {
    let layerWidth = CGFloat(10)
    let midX = self.bounds.midX - layerWidth / 2.0
    instanceLayer.frame = CGRect(
      x: midX,
      y: 0.0,
      width: layerWidth,
      height: layerWidth * lengthMultiplier)
    instanceLayer.backgroundColor = UIColor.white.cgColor
    replicatorLayer.addSublayer(instanceLayer)

  }

  func setUpLayerFadeAnimation() {
    fadeAnimation.fromValue = 1.0
    fadeAnimation.toValue = 0.0
    fadeAnimation.repeatCount = Float(Int.max)
    replicatorLayer.add(fadeAnimation, forKey: nil)
  }


}
