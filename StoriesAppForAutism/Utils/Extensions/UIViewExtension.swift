//
//  UIViewExtension.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 13.06.22.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        set {
            layer.allowsEdgeAntialiasing = true
            layer.cornerRadius = newValue
            layer.masksToBounds = true
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                let maskLayer = CAShapeLayer()
                maskLayer.frame = strongSelf.bounds
                let bezierPath = UIBezierPath(roundedRect: strongSelf.bounds, cornerRadius: strongSelf.layer.cornerRadius)
                maskLayer.path = bezierPath.cgPath
                strongSelf.layer.mask = maskLayer
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
      }
}
