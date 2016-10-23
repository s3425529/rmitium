/*
* Copyright (c) 2013-2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import AVFoundation

/**
 * Audio player that uses AVFoundation to play looping background music and
 * short sound effects. For when using SKActions just isn't good enough.
 */
public class SKTAudio {
    private let bgmMusics = ["slow.mp3", "fast.wav"]
    private var currentBgm: String?
    public var backgroundMusicPlayer: AVAudioPlayer?
    public var soundEffectPlayer: AVAudioPlayer?
    
    public class func sharedInstance() -> SKTAudio {
        return SKTAudioInstance
    }
    
    // Play background music based on level
    public func playBackgroundMusic(level: Int) {
        var url = NSBundle.mainBundle().URLForResource(bgmMusics[0], withExtension: nil)
        switch level {
        case UtilitiesPortal.levelOne:
            url = NSBundle.mainBundle().URLForResource(bgmMusics[0], withExtension: nil)
            currentBgm = bgmMusics[0]
            break
        case UtilitiesPortal.levelTwo:
            url = NSBundle.mainBundle().URLForResource(bgmMusics[1], withExtension: nil)
            currentBgm = bgmMusics[1]
            break
        case UtilitiesPortal.levelThree:
            url = NSBundle.mainBundle().URLForResource(bgmMusics[0], withExtension: nil)
            currentBgm = bgmMusics[0]
            break
        default:
            url = NSBundle.mainBundle().URLForResource(bgmMusics[0], withExtension: nil)
            currentBgm = bgmMusics[0]
            break
        }
        //let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            print("Could not find music file for level: \(level)")
            return
        }
        
        var error: NSError? = nil
        do {
            // Allow other app to play music
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch let error1 as NSError {
            error = error1
            backgroundMusicPlayer = nil
        }
        if let player = backgroundMusicPlayer {
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
    
    // Check if the background music should be changed or continue
    public func continueMusic(level: Int) -> Bool {
        switch level {
        case UtilitiesPortal.levelOne:
            return currentBgm == bgmMusics[0]
            
        case UtilitiesPortal.levelTwo:
            return currentBgm == bgmMusics[1]
            
        case UtilitiesPortal.levelThree:
            return currentBgm == bgmMusics[0]
            
        default:
            return currentBgm == bgmMusics[0]
        }
    }
    
    // Pause background music
    public func pauseBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if player.playing {
                player.pause()
            }
        }
    }
    
    // Resume background music
    public func resumeBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if !player.playing {
                player.play()
            }
        }
    }
    
    // Play sound effect (not in used)
    public func playSoundEffect(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        var error: NSError? = nil
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOfURL: url!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch let error1 as NSError {
            error = error1
            soundEffectPlayer = nil
        }
        if let player = soundEffectPlayer {
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        } else {
            print("Could not create audio player: \(error!)")
        }
    }
}

private let SKTAudioInstance = SKTAudio()
