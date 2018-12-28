//
//  GradientView.swift
//  Alarm Clock
//
//  Created by Roman Churkin on 14/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit


@IBDesignable
final class GradientView: UIView {
    
    @IBInspectable var progress: CGFloat = 0 {
        didSet { updateGradient() }
    }

    
    // MARK: -
    
    private let startGradient: Gradient = {
        return Gradient(startColor: #colorLiteral(red: 1, green: 0.4156862745, blue: 0, alpha: 1), endColor: #colorLiteral(red: 0, green: 0.2941176471, blue: 0.8705882353, alpha: 1))
    }()
    private let endGradient: Gradient = {
        return Gradient(startColor: #colorLiteral(red: 1, green: 0.2862745098, blue: 0, alpha: 1), endColor: #colorLiteral(red: 0.0431372549, green: 0, blue: 0.4980392157, alpha: 1))
    }()
    

    // MARK: -
    
    override class var layerClass : AnyClass { return CAGradientLayer.self }
    
    
    // MARK: -
    
    private func updateGradient() {
        let startColor = startGradient.color(for: progress)
        let endColor = endGradient.color(for: progress)

        let layer = self.layer as! CAGradientLayer
        layer.colors = [startColor.cgColor, endColor.cgColor]
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
    }
    
}


private struct Gradient {
    
    private struct ColorRGB {
        
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        
        init(_ color: UIColor) {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }
        
    }
    
    private let startColor: ColorRGB
    private let endColor: ColorRGB
    
    init(startColor: UIColor, endColor: UIColor) {
        self.startColor = ColorRGB(startColor)
        self.endColor = ColorRGB(endColor)
    }
    
    func color(for progress: CGFloat) -> UIColor {
        let red   = startColor.red   + progress * (endColor.red   - startColor.red  )
        let green = startColor.green + progress * (endColor.green - startColor.green)
        let blue  = startColor.blue  + progress * (endColor.blue  - startColor.blue )
        
        return UIColor(red:   red,
                       green: green,
                       blue:  blue,
                       alpha: min(startColor.alpha, endColor.alpha))
    }
    
}

