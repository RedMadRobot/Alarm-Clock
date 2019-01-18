//
//  CircleView.swift
//  ACSlider
//
//  Created by Roman Churkin on 25/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


@IBDesignable
final class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        layer.borderColor = tintColor.cgColor
        layer.borderWidth = 2
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = tintColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.height, bounds.width) / 2
    }
    
}
