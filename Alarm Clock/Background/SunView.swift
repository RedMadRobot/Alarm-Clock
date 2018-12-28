//
//  SunView.swift
//  Alarm Clock
//
//  Created by Roman Churkin on 25/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


final class SunView: UIView {
    
    private let sun = UIImageView(image: #imageLiteral(resourceName: "sun"))
    private let brightSun = UIImageView(image: #imageLiteral(resourceName: "sun-bright"))
    
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        addSubview(sun)
        addSubview(brightSun)
        
        sun.alpha = 0.0
        brightSun.alpha = 1.0
        
        UIView.animateLoop(withDuration: 3, {
            self.sun.alpha = 1.0
            self.brightSun.alpha = 0.0
        })
    }
    
    override var intrinsicContentSize: CGSize {
        let sunSize = sun.image!.size
        let brightSunSize = brightSun.image!.size
        
        return CGSize(width: max(sunSize.width, brightSunSize.width),
                      height: max(sunSize.height, brightSunSize.height))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sunSize = sun.image!.size
        sun.frame = CGRect(origin: CGPoint(x: bounds.midX - sunSize.width/2,
                                           y: bounds.midY - sunSize.height/2),
                           size: sunSize)
        
        let brightSunSize = brightSun.image!.size
        brightSun.frame = CGRect(origin: CGPoint(x: bounds.midX - brightSunSize.width/2,
                                                 y: bounds.midY - brightSunSize.height/2),
                                 size: brightSunSize)
        
    }
}
