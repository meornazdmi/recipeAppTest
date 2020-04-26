//
//  DesignableUITextField.swift
//  asis
//
//  Created by FatahZull on 22/05/2018.
//  Copyright © 2018 FatahZullAppreka. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableUITextField:  UITextField {
    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor : UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 24, height: 24))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 28, height: 28))
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }
            
        }
    }
    
//    @IBInspectable var rightImage : UIImage? {
//        didSet {
//            if let image = rightImage{
//                rightViewMode = .always
//                let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 24, height: 24))
//                imageView.image = image
//                imageView.tintColor = tintColor
//                
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DesignableUITextField.imageTapped(gesture:)))
//                // add it to the image view;
//                imageView.addGestureRecognizer(tapGesture)
//                // make sure imageView can be interacted with by user
//                imageView.isUserInteractionEnabled = true
//                
//                let view = UIView(frame : CGRect(x: 0, y: 0, width: 28, height: 28))
//                view.addSubview(imageView)
//                rightView = view
//            }else {
//                rightViewMode = .never
//            }
//            
//        }
//        
//        
//    }
//    
//    @objc func imageTapped(gesture: UIGestureRecognizer) {
//        // if the tapped view is a UIImageView then set it to imageview
//        if (gesture.view as? UIImageView) != nil {
//            self.text = ""
//        }
//    }

    
    @IBInspectable var placeholderColor : UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor!])
            attributedPlaceholder = str
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 50, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 50, dy: 5)
    }
    
}

