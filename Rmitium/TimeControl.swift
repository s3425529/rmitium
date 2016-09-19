//
//  timeContorl.swift
//  Rmitium
//
//  Created by Max on 9/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
class TimeControl {
    
    var timeLabel : Int!
    var limitTime: Int!
    var pauseTime = 1
    var countDownTimer: NSTimer?
   // var action:()->Void
    
    var remainSecond :Int = 0 {
        willSet{
            timeLabel = newValue
            if newValue >= limitTime {
                //action()
                isCount = false
            }
        }
    }
    
    var isCount = false {
        willSet {
            if newValue {
                //countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TimeControl.updateTime(_:)), userInfo: nil, repeats: true)
                countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
                remainSecond = pauseTime
              
            }
            else {
                countDownTimer?.invalidate()
                countDownTimer = nil
            }
        }
    }
    
    init(limitTime:Int) {
        self.limitTime = limitTime
    }
    
    func startTimer() {
        isCount = true
    }
    func stopTimer() {
        isCount = false
    }
    @objc func updateTime(timer: NSTimer) {
         remainSecond += 1
    }
    func pause(isTrue: Bool ){
        
        if isTrue{
            pauseTime = remainSecond
            stopTimer()
        }else{
            remainSecond = pauseTime
            startTimer()
        }
    }

    
}
