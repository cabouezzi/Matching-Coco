//
//  SoundManager.swift
//  Matching Coco
//
//  Created by Chaniel Ezzi on 3/31/19.
//  Copyright © 2019 Lil Coco™. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
        case goingBad
        
    }
    
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFileName = ""
        
        switch effect {
            case .flip:
                soundFileName = "cardflip"
            
            case .shuffle:
                soundFileName = "shuffle"
            
            case .match:
                soundFileName = "dingcorrect"
            
            case .nomatch:
                soundFileName = "dingwrong"
            
            case .goingBad:
                soundFileName = "GoingBadInLilCoco"
            
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find sound file name \(soundFileName) in the bundle")
            return
        }
        
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        
        do {
            
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        audioPlayer?.play()
            
        } catch {
            print("Couldn't create the audio player object for sound file \(soundFileName)")
            
        }
    }
}
