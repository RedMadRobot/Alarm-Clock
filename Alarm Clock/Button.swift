//
//  Button.swift
//  Alarm Clock
//
//  Created by Roman Churkin on 25/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


@IBDesignable
final class Button: UIButton {
    
    static func make() -> Button {
        let button = Button(type: .system)
        button.configure()
        
        return button
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = tintColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
    
    private func configure() {
        contentEdgeInsets = UIEdgeInsets(top: 18,
                                         left: contentEdgeInsets.left,
                                         bottom: 16,
                                         right: contentEdgeInsets.right)
        
        layer.borderWidth = 2
        layer.borderColor = tintColor.cgColor
        
        titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 14)
    }
    
}
