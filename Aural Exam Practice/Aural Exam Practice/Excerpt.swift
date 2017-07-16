//Base class taken from previous projects
//Some was done in-class or possibly came from the book
//Other parts are original.

import UIKit
import AVFoundation

class Excerpt: NSObject {
    var songPlayer:AVAudioPlayer?
    var songLocation:URL?
    
    override init() {
        // Not currently used
    }
    
    // Constructor with a full song URL given
    init(_ fileName:String) {
        // Create song location URL
        let audioFileName = URL(fileURLWithPath: fileName).deletingPathExtension().relativeString
        let audioFileExtension = URL(fileURLWithPath: fileName).pathExtension
        songLocation = Bundle.main.url(forResource: audioFileName, withExtension: audioFileExtension)
        
        // Prepare the AVAudioPlayer for this song
        do {
            try songPlayer = AVAudioPlayer(contentsOf: songLocation!)
            //set to loop forever to account for the short solo clips
            songPlayer?.numberOfLoops = -1
            songPlayer?.prepareToPlay()
        } catch let error  {
            print(error.localizedDescription)
        }
        
    }
    
    // Constructor with separate file name and extension
    init(fileName:String, fileExtension:String) {
        // Create song location URL
        songLocation = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if songLocation == nil {
            return //cannot locate any file so exit
        }
        
        // Prepare the AVAudioPlayer for this song
        do {
            try songPlayer = AVAudioPlayer(contentsOf: songLocation!)
            songPlayer?.numberOfLoops = -1
            songPlayer?.prepareToPlay()
        } catch let error  {
            print(error.localizedDescription)
        }
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
    // Not used in this project (included for future reference/enhancements)
    func setVolume(vol:Float) {
        songPlayer?.volume = vol
    }
    // Wrapper for AVAudioPlayer time control
    // Not used in this project (alternative to stop w/rewind)
    func setCurrentTime(time:Double) {
        songPlayer?.currentTime = time
    }
    
}
