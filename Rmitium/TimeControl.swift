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
    var pauseTime = 0
    var countDownTimer: NSTimer?
    var tag:Bool!
   // var action:()->Void
    
    var remainSecond :Int = 0 {
        willSet{
            timeLabel = newValue
            
            if tag == true{
                if newValue >= limitTime {
                    //action()
                    isCount = false
                }
            }else{
                if newValue <= 0 {
                    isCount = false
                }
            }
            
        }
    }
    
    var isCount = false {
        willSet {
            if newValue {
                countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TimeControl.updateTime(_:)), userInfo: nil, repeats: true)
                if tag == true{
                    remainSecond = pauseTime
                }else{
                    remainSecond = limitTime
                }
                
              
            }
            else {
                countDownTimer?.invalidate()
                countDownTimer = nil
            }
        }
    }
    
    // Initialize the timer. 
    // When the tag is true, the timer will increase 1 each second.
    // When the tag is false, the timer will reduce 1 each second form limitTime.
    init(limitTime:Int, tag:Bool) {
        self.limitTime = limitTime
        self.tag = tag
    }
    
    // Start the timer
    func startTimer() {
        isCount = true
    }
    
    // Stop the timer
    func stopTimer() {
        isCount = false
    }
    
    @objc func updateTime(timer: NSTimer) {
        if tag == true{
            remainSecond += 1
        }else{
            remainSecond -= 1
        }
        
    }
    
    // Pause the timer
    func pause(isTrue: Bool ){
        if isTrue {
            pauseTime = remainSecond
            stopTimer()
        }
        else {
            remainSecond = pauseTime
            startTimer()
        }
    }
}
