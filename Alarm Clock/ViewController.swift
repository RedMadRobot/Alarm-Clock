//
//  ViewController.swift
//  Alarm Clock
//
//  Created by Roman Churkin on 12/12/2018.
//  Copyright © 2018 Redmadrobot. All rights reserved.
//

import UIKit
import ACSlider


final class ViewController: UIViewController {

    @IBOutlet var headerLabel: UILabel! {
        didSet {
            guard let text = headerLabel.text else { return }
            headerLabel.attributedText =
                NSAttributedString(string: text, attributes: [NSAttributedString.Key.kern: 3.5])
        }
    }
    @IBOutlet var hoursSlider: ACSlider!
    @IBOutlet var minsSlider: ACSlider!

    
    // MARK: -
    
    private var customView: GradientView {
        return self.view as! GradientView
    }
    private let sunView = SunView(frame: .zero)
    
    
    // MARK: -
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(sunView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sliderUpdate()
    }
    
    
    // MARK: -
    
    private func updateSun(for progress: CGFloat) {
        let size = sunView.intrinsicContentSize
        let y = view.bounds.height * progress
        let sunOrigin = CGPoint(x: view.bounds.midX - size.width/2, y: y)
        sunView.frame = CGRect(origin: sunOrigin, size: size)
    }
    
    
    // MARK: -
    
    @IBAction func sliderUpdate() {
        var progress = hoursSlider.value/hoursSlider.maxValue
        progress += minsSlider.value/minsSlider.maxValue/hoursSlider.maxValue
        progress = abs(progress - 0.5) / 0.5
        
        customView.progress = progress
        
        UIView.animateEasy { self.updateSun(for: progress) }
    }
    
}

