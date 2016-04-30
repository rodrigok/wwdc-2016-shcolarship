//
//  UIButtonView.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 23/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit


@IBDesignable class UIButtonRounded: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}