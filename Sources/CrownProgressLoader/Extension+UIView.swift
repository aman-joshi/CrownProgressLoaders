//
//  Extension + UIView.swift
//  
//
//  Created by Aman Joshi on 25/05/21.
//

import UIKit

extension UIView {

  public func show(_ view:CircularProgressView) {
    DispatchQueue.main.async {
      if !self.subviews.contains(view) {
        self.updateConstraints(view, width: view.width)
        view.animateStroke()
        view.animateRotation()
      }
    }
  }

  public func show(_ view:StandardProgressView) {
    DispatchQueue.main.async {
      if !self.subviews.contains(view) {
        self.updateConstraints(view, width: view.width)
      }
    }
  }

  public func show(_ view:ReplicatorProgressView) {
    DispatchQueue.main.async {
      if !self.subviews.contains(view) {
        self.updateConstraints(view, width: view.width)
      }
    }
  }

  public func dismiss(_ view:UIView) {
    DispatchQueue.main.async {
      if self.subviews.contains(view) {
        for subview in self.subviews {
          if let progressView = subview as? CircularProgressView {
            progressView.removeFromSuperview()
            return
          }
          if let stdProgressView = subview as? StandardProgressView {
            stdProgressView.removeFromSuperview()
            return
          }
          if let repProgressView = subview as? ReplicatorProgressView {
            repProgressView.removeFromSuperview()
            return
          }
        }
      }
    }
  }

  func updateConstraints(_ view:UIView, width:CGFloat) {
    self.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    if let view = view as? CircularProgressView {
      NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        view.widthAnchor.constraint(equalToConstant: width),
        view.heightAnchor.constraint(equalTo: view.widthAnchor)
      ])
    }
    else if let view = view as? StandardProgressView {
      self.addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        view.widthAnchor.constraint(equalToConstant: width),
        view.heightAnchor.constraint(equalTo: view.widthAnchor)
      ])
    }
    else if let view = view as? ReplicatorProgressView {
      NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        view.widthAnchor.constraint(equalToConstant: width),
        view.heightAnchor.constraint(equalTo: view.widthAnchor)
      ])
    }
  }


}

