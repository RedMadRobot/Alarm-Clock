//
//  ThumbView.swift
//  ACSlider
//
//  Created by Roman Churkin on 25/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


@IBDesignable
final class ThumbView: UIView {
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var value: String? {
        get { return valueLabel.text }
        set { valueLabel.text = newValue }
    }
    
    
    // MARK: -
    
    private var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = "00"
        
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        
        return label
    }()
    
    private var thumbView: UIView = {
        return CircleView(frame: .zero)
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 60, height: 86)
    }
    
    
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
        PodFontsHelper.registerFonts()
        valueLabel.font = UIFont(name: "BebasNeueWhatever", size: 56)
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(thumbView)
        
        configureLayout()
        
        valueLabel.textColor = tintColor
        titleLabel.textColor = tintColor
        thumbView.tintColor = tintColor
        
        thumbView.transform = CGAffineTransform(scaleX: 0,
                                                y: 0)
        thumbView.alpha = 0
    }
    
    private func configureLayout() {
        valueLabel.frame = CGRect(x: 0,
                                  y: 0,
                                  width: intrinsicContentSize.width,
                                  height: intrinsicContentSize.height)
        
        thumbView.frame = CGRect(x: intrinsicContentSize.width/2 - 22,
                                 y: intrinsicContentSize.height/2 - 22,
                                 width: 44,
                                 height: 44)
        
        titleLabel.frame = CGRect(x: 0,
                                  y: intrinsicContentSize.height - 18,
                                  width: intrinsicContentSize.width,
                                  height: 18)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        valueLabel.textColor = tintColor
        titleLabel.textColor = tintColor
        thumbView.tintColor = tintColor
    }
    
    
    // MARK: -
    
    func animateTrackingBegin() {
        UIView.animateEasy {
            self.valueLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            self.thumbView.transform = CGAffineTransform.identity
            self.thumbView.alpha = 1
        }
    }
    
    func animateTrackingEnd() {
        UIView.animateEasy {
            self.valueLabel.transform = CGAffineTransform.identity
            self.thumbView.transform = CGAffineTransform(scaleX: 0,
                                                         y: 0)
            self.thumbView.alpha = 0
        }
    }
    
}


