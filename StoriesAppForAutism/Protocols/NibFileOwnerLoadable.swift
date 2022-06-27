//
//  NibFileOwnerLoadable.swift
//  SocialApp
//
//  Created by Kristina Simova on 21.05.22.
//

import UIKit

public protocol NibFileOwnerLoadable: AnyObject {
    static var nib: UINib { get }
}
public extension NibFileOwnerLoadable where Self: UIView {
    static var nib: UINib {
        let test = UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        return test
    }
    
    func instantiateFromNib() -> UIView? {
        let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    func loadNibContent() {
        guard let view = instantiateFromNib() else {
            fatalError("Failed to instantiate nib \(Self.nib)")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        let views = ["view": view]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        addConstraints(verticalConstraints + horizontalConstraints)
        
    }
}
