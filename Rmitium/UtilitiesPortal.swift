//
//  UtilitiesPortal.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/10/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AudioToolbox
import Foundation
import UIKit
import SpriteKit


class UtilitiesPortal {
    //static let mainScene = GameScene(fileNamed:"GameScene")
    static let stateAnswer = 0
    static let stateResult = 1
    static let stateReview = 2
    static let stateInfo = 3
    static let stateInfoResult = 4
    static let stateFact = 5
    static let stateHome = 6
    
    static let modeStandard = 0
    static let modeTrial = 1
    static let modeBeat = 2
    
    static let firstTime = -3
    static let firstResult = -2
    static let defaultScore = -1
    static let levelOne = 1
    static let levelTwo = 2
    static let levelThree = 3
    
    static let levelLabelNames = ["lvl01", "lvl02", "lvl03", "setting"]
    static let levelButtonNames = ["lvl01Btn", "lvl02Btn", "lvl03Btn", "settingBtn"]
    static let levelMedalNames = ["lvl01Medal", "lvl02Medal", "lvl03Medal", "lvl04Medal"]
    
    static let levelGameMode = ["lvl2standard", "lvl2timetrial", "lvl2extreme"]
    static let modeLabelNames = ["mode01", "mode02", "mode03"]
    static let modeButtonNames = ["mode01Btn", "mode02Btn", "mode03Btn"]
    static let modeMedalNames = ["mode01Medal", "mode02Medal", "mode03Medal"]
    static let levelOneAnswers = ["acid", "alcohol", "aldehyde", "alkene", "amide", "amine", "ester", "ether", "phenol" ,"thioether"]
    static let levelTwoWidth = 10
    static let levelTwoHeight = 6
    static let levelTwoImageWidth: CGFloat = 0.09
    static let levelTwoImageHeight: CGFloat = 0.12
    static let levelTwoNil = -1
    
    static let levelThreeAnswers = ["ionic", "h-bonding", "dipole-dipole", "vanderwaals"]
    
    static let levelLabelTexts = ["Level 1: Functional Groups",
                                  "Level 2: Structure Classification",
                                  "Level 3: Intermolecular Forces", "SETTINGS"]
    
    static let modeLabelTexts = ["Standard", "Time Trial", "Extreme"]
    
    static let settingLabelTexts = ["Background Music", "Sound Effects", "Left-Hand Mode", "Reset Scores"]
    static let settingLabelNames = ["background", "soundEffects", "leftHand", "reset"]
    static let settingLabelButtons = ["backgroundBtn", "effectsBtn", "leftHandBtn", "resetBtn"]
    
    static let emptyString = ""
    
    static let homeButtonName = "homeBtn"
    static let helpButtonName = "helpBtn"
    static let settingButtonName = "setting"
    static let tickButtonName = "tickBtn"
    static let showButtonName = "showBtn"
    static let nextButtonName = "nextBtn"
    static let infoButonName = "infoBtn"
    static let redoButtonName = "redo"
    static let shareButtonName = "share"
    static let backButtonName = "back"
    static let yesButtonName = "yesBtn"
    static let noButtonName = "noBtn"
    static let timeOutRetryName = "timeOutRetryBtn"
    static let timeOutHomeName = "timeOutHomeBtn"
    static let factLabelName = "factLbl"
    static let factOverlayName = "factOvl"
    static let factMultiLine = "factMultiLine"
    static let settingViewButtonName = "settingView"
   
    
    static let buttonLevelWidth: CGFloat = 1153
    static let buttonLevelHeight: CGFloat  = 317
    
    static let alphabet = ["A", "B", "C", "D", "E", "F", "G"] //HIJKLMNOPQRSTUVXYZ"
    
    static let infoArrowNames = ["arrow1", "arrow2", "arrow3", "arrow4", "arrow5", "arrow6", "arrow7", "arrow8"]
    static let infoLabelNames = ["info1", "info2", "info3", "info4", "info5", "info6", "info2-2", "info3-2", "info5-2"]
    
    static let screenSize: CGRect = UIScreen.mainScreen().bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    static let hexImageSize = screenHeight*0.15
    
    static let navLabelFont = "ArialRoundedMTBold"
    static let navLabelSize = CGFloat(screenWidth/25)
    static let navImgSize = screenHeight*0.10
    
    static let factFont = "ArialRoundedMTBold"
    static let factSize = CGFloat(screenWidth/35)
    static let scoreText = "Score:"
    
    static let levelLabelSize = CGFloat(screenWidth/30)
    static let levelLabelFont = "Avenir-Black"
    static let levelLabelAnswerSize = CGFloat(screenWidth/40)
    
    static let borderSize = CGFloat(screenWidth/15)
    static let imageBorderSize = CGFloat(screenWidth/30)

    
    static let imageWidth = screenWidth*0.6
    static let imageHeight = screenHeight*0.6
    
    static var score = 0
    
    static var totalQuestions = 0
    static var effect = "sfx"
    
    //static var record = [Int]()
    static func setBgm(){
        let soundSetting = DataHandler.getSettings().getSound
        if soundSetting {
            if (SKTAudio.sharedInstance().backgroundMusicPlayer == nil){
                SKTAudio.sharedInstance().playBackgroundMusic("bgm.mp3")
            }            
            else {
                SKTAudio.sharedInstance().resumeBackgroundMusic()
            }
        }
        else {
            SKTAudio.sharedInstance().pauseBackgroundMusic()
        }
    }
}

/*extension SystemSoundID {
    static func playFileNamed(fileName: String, withExtenstion fileExtension: String? = "aif") {
        var sound: SystemSoundID = 0
        if let soundURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: fileExtension) {
            AudioServicesCreateSystemSoundID(soundURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
    }
}*/
