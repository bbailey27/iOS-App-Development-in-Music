//
//  Song.swift
//  EDM
//
//  Created by Bridget Bailey on 2/10/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class Song: NSObject {
    var songPlayer:AVAudioPlayer?
    var songLocation:URL?
    var images:[UIImage] = []
    var animationDuration = 0.5 //default

    override init() {
        // Not currently used
    }
    
    // Constructor with a full song URL given
    init(_ fileName:String, imageNames:[String], secondsPerBeat:Double) {
        // Create song location URL
        let audioFileName = URL(fileURLWithPath: fileName).deletingPathExtension().relativeString
        let audioFileExtension = URL(fileURLWithPath: fileName).pathExtension
        songLocation = Bundle.main.url(forResource: audioFileName, withExtension: audioFileExtension)
        
        // Prepare the AVAudioPlayer for this song
        do {
            try songPlayer = AVAudioPlayer(contentsOf: songLocation!)
            songPlayer?.prepareToPlay()
        } catch let error  {
            print(error.localizedDescription)
        }
        
        // Prepare the associated animation
        for imageName in imageNames {
            let image = UIImage(named: imageName)
            images.append(image!)
        }
        animationDuration = secondsPerBeat
        
    }
    
    // Constructor with separate file name and extension
    init(fileName:String, fileExtension:String, imageNames:[String], secondsPerBeat:Double) {
        // Create song location URL
        songLocation = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if songLocation == nil {
            return //cannot locate any file so exit
        }
        
        // Prepare the AVAudioPlayer for this song
        do {
            try songPlayer = AVAudioPlayer(contentsOf: songLocation!)
            songPlayer?.prepareToPlay()
        } catch let error  {
            print(error.localizedDescription)
        }
        
        // Prepare the associated animation
        for imageName in imageNames {
            let image = UIImage(named: imageName)
            images.append(image!)
        }
        animationDuration = secondsPerBeat
    }
    
    // Wrapper for AVAudioPlayer play() method
    func play() {
        songPlayer?.play()
    }
    // Wrapper for AVAudioPlayer pause() method
    func pause() {
        songPlayer?.pause()
    }
    // Stop the song and rewind so it will play from the start next time
    func stop() {
        songPlayer?.stop()
        songPlayer?.currentTime = 0.0
    }
    // Wrapper for AVAudioPlayer volume control
    func setVolume(vol:Float) {
        songPlayer?.volume = vol
    }
    // Wrapper for AVAudioPlayer time control
    // Not used in this project (alternative to stop w/rewind)
    func setCurrentTime(time:Double) {
        songPlayer?.currentTime = time
    }
    
}
