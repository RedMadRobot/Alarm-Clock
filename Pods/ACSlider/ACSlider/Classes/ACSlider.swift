//
//  ACSlider.swift
//  ACSlider
//
//  Created by Roman Churkin on 12/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


@IBDesignable
public final class ACSlider: UIControl {
    
    @IBInspectable var title: String? {
        get { return thumbView.title }
        set { thumbView.title = newValue }
    }
    @IBInspectable public var maxValue: CGFloat = 23
    

    // MARK: -
    
    private(set) public var value: CGFloat = 0 {
        didSet { thumbView.value = String(format: "%02.0f", value) }
    }
    
    private var thumbSize: CGSize {
        return thumbView.intrinsicContentSize
    }
    
    private let thumbView: ThumbView = {
        let thumbView = ThumbView(frame: .zero)
        thumbView.frame = CGRect(origin: .zero, size: thumbView.intrinsicContentSize)
        thumbView.isUserInteractionEnabled = false
        return thumbView
    }()
    
    
    private let minTrackView: UIView = ACSlider.prepareTrackView()
    private let maxTrackView: UIView = ACSlider.prepareTrackView()
    
    private static func prepareTrackView() -> UIView {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 1
        view.isUserInteractionEnabled = false
        return view
    }
    
    
    // MARK: -
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric,
                      height: thumbSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        tintColorUpdate()
        
        addSubview(minTrackView)
        addSubview(maxTrackView)
        addSubview(thumbView)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        value = CGFloat(Int.random(in: 0..<Int(maxValue)))
    }
    
    override public func tintColorDidChange() {
        super.tintColorDidChange()
        tintColorUpdate()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        recalculateFrames()
    }
    
    
    // MARK: -
    
    private func tintColorUpdate() {
        thumbView.tintColor = tintColor
        minTrackView.backgroundColor = tintColor
        maxTrackView.backgroundColor = tintColor
    }
    
    private func recalculateFrames() {
        let stepWidth = (bounds.width - thumbSize.width) / maxValue
        let currentX = stepWidth * value
        
        thumbView.frame = CGRect(origin: CGPoint(x: currentX, y: 0),
                                 size: thumbSize)
        
        minTrackView.frame = CGRect(origin: CGPoint(x: 0, y: bounds.midY - 1),
                                    size: CGSize(width: thumbView.frame.minX, height: 2))
        
        maxTrackView.frame = CGRect(origin: CGPoint(x: thumbView.frame.maxX, y: bounds.midY - 1),
                                    size: CGSize(width: bounds.width - thumbView.frame.maxX, height: 2))
    }
    
    
    // MARK: -
    
    private func checkBounds<T>(start: T, end: T, x: T ) -> T where T : Comparable {
        return max(start, min(end, x))
    }
    
    private func updateValue(for touch: UITouch, animated: Bool = false) {
        let x = checkBounds(start: thumbSize.width / 2,
                            end: bounds.width - thumbSize.width / 2,
                            x: touch.location(in: self).x)
        
        let position = x - thumbSize.width / 2
        
        let progress = position / (bounds.width - thumbSize.width)
        
        value = maxValue * progress
        
        if animated {
            UIView.animateEasy { self.recalculateFrames() }
        } else {
            recalculateFrames()
        }
        
        sendActions(for: .valueChanged)
    }
    
    
    // MARK: -
    
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let result = super.beginTracking(touch, with: event)
        let insideThumb = thumbView.frame.contains(touch.location(in: self))
        
        if result && insideThumb {
            thumbView.animateTrackingBegin()
            updateValue(for: touch, animated: true)
        }
        
        return result && insideThumb
    }
    
    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(for: touch, animated: false)
        return super.continueTracking(touch, with: event)
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbView.animateTrackingEnd()
        
        value = value.rounded()
        
        UIView.animateEasy { self.recalculateFrames() }
        
        sendActions(for: .valueChanged)
    }
    
}
