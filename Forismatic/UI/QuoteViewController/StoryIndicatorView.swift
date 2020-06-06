//
//  ProgressView.swift
//  Forismatic
//
//  Created by Andrey on 06.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

class StoryIndicatorView: UIView {
    
    // MARK: Public
    
    var fillPercentValue: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(rect.height)
        context?.setStrokeColor(UIColor(named:"primaryBlue")!.cgColor)
        
        context?.move(to: CGPoint(x: 0, y: 0))
        let endPointX = rect.width * fillPercentValue / 100.0
        context?.addLine(to: CGPoint(x: endPointX, y: 0))
        
        context?.strokePath()
    }
    
}
