//
//  UIViewHelpers.swift
//  ACSlider
//
//  Created by Roman Churkin on 25/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


extension UIView {
    
    class func animateEasy(withDuration duration: TimeInterval = 0.15,
                           _ animations: @escaping () -> Void) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: nil)
        
    }
    
    class func animateLoop(withDuration duration: TimeInterval = 0.15,
                           _ animations: @escaping () -> Void) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut, .repeat, .autoreverse],
                       animations: animations,
                       completion: nil)
        
    }
    
}
