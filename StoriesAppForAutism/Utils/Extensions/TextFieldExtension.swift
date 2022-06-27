//
//  TextFieldExtension.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 15.06.22.
//

import UIKit

class InsetTextField: UITextField {
    var eye  = UIButton(type: .custom)
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        font = UIFont(name: "Poppins-Regular", size: 18.0)
        
        if isSecureTextEntry == true {
            eye.setImage(UIImage(named: "see_icon_on"), for: .normal)
            eye.imageView?.contentMode = .scaleAspectFit
            eye.addTarget(self, action: #selector(self.togglePasswordVisibility), for: .touchUpInside)
            eye.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            rightViewMode = .whileEditing
            rightView = eye
            translatesAutoresizingMaskIntoConstraints = false
            rightView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
        }
    }
    
    @objc func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        
        if !isSecureTextEntry {
            eye.setImage(UIImage(named: "see_icon_off"), for: .normal)
        }else {
            eye.setImage(UIImage(named: "see_icon_on"), for: .normal)
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
