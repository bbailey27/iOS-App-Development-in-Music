//
//  MusicPlayer.swift
//  Music Player
//
//  Created by Bridget Bailey on 2/7/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayer: NSObject {
    var player:AVAudioPlayer?
    var audioFileLocation:URL?
    
    override init() { //example x = MusicPlayer()
    // in case you need to use this class without assigning an audiofile to it
    }
    
    init(_ fileName:String) { // x = MusicPlayer("song.m4a")
        let audioFileName = URL(fileURLWithPath: fileName).deletingPathExtension().relativeString
        let audioFileExtension = URL(fileURLWithPath: fileName).pathExtension
        
        audioFileLocation = Bundle.main.url(forResource: audioFileName, withExtension: audioFileExtension)
        
        do {
            try player = AVAudioPlayer(contentsOf: audioFileLocation!)
            player?.prepareToPlay()
        } catch let error  {
            print(error.localizedDescription)
        }
    }
    
    init(fileName:String, fileExtension:String) { // example x = MusicPlayer(fileName: "song", fileExtension: "m4a")
        
        audioFileLocation = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if audioFileLocation == nil {
            return //cannot locate any file so exit
        }
        
        do {
            try player = AVAudioPlayer(contentsOf: audioFileLocation!)
            player?.prepareToPlay()
        } catch let error  {
            print(error.localizedDescription)
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.stop()
        player?.currentTime = 0.0 // this creates 'rewind'
    }
}
