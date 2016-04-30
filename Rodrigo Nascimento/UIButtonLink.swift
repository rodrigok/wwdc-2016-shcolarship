//
//  UIButtonView.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 23/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit


@IBDesignable class UIButtonLink: UIButtonRounded {
    @IBInspectable var url: String = ""
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let url  = NSURL(string: self.url)

        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
}