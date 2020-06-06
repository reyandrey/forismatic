//
//  QuoteTimer.swift
//  Forismatic
//
//  Created by Andrey on 06.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

class QuoteTimer {
    private let timeInterval: Double = 10.0
    private let timeintervalToUpdate: Double = 0.001
    private var timer: Timer?
    private var time: Double = 0 {
        didSet { didUpdateProgress?(CGFloat(time/timeInterval * 100)) }
    }
    
    var onPause: Bool = false {
        didSet { handlePause() }
    }
    
    var didUpdateProgress: ((CGFloat) -> Void)? = nil
    var didCountdown: (() -> Void)? = nil
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: timeintervalToUpdate, target: self, selector: #selector(handleUpdate(_:)), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func reset() {
        timer?.invalidate()
        time = 0
    }
    
    private func handlePause() {
        if onPause { timer?.invalidate() }
        else { start() }
    }
    
    @objc private func handleUpdate(_ sender: Any) {
        time += timeintervalToUpdate
        guard time <= timeInterval else { reset(); didCountdown?(); return }
    }
}
