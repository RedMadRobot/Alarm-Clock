//
//  UIFont.swift
//  ACSlider
//
//  Created by Roman Churkin on 15/01/2019.
//

import UIKit


struct PodFontsHelper {
    
    static var fonts = false
    
    static func registerFonts() {
        guard !fonts else { return }
        fonts = true
        
        self.registerFont(fontName: "BebasNeueWhatever", fontExtension: "ttf")
        self.registerFont(fontName: "Montserrat-SemiBold", fontExtension: "ttf")
    }
    
    static func registerFont(fontName: String,
                             fontExtension: String) {
        
        let bundle = Bundle(for: ACSlider.self)
        
        guard let resourcesBundleURL = bundle.url(forResource: "ACSlider",
                                                  withExtension: "bundle"),
            let resourcesBundle = Bundle(url: resourcesBundleURL) else {
            fatalError("Couldn't find resources bundle")
        }
        
        guard let fontURL = resourcesBundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font. Maybe it was already registered.")
            return
        }

    }
    
}
