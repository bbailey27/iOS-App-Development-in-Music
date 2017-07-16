//
//  SecondViewController.swift
//  MIDI Player
//
//  Created by Bridget Bailey on 2/21/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    var midiPlayer:AVMIDIPlayer?
    var midiPlayCompletion:AVMIDIPlayerCompletionHandler = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let soundfont = Bundle.main.url(forResource: "gs_instruments", withExtension: "dls")
        
        let midifile = Bundle.main.url(forResource: "Scarborough_Fair", withExtension: "mid")
        
        do {
            try midiPlayer = AVMIDIPlayer(contentsOf: midifile!, soundBankURL: soundfont!)
        } catch let error {
            print(error.localizedDescription)
        }
        
        midiPlayer?.prepareToPlay()
        
        midiPlayCompletion = {self.donePlaying() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func midiTransport(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0: // play
            midiPlayer?.play(midiPlayCompletion)
        case 1: // pause
            midiPlayer?.stop()
        default:
            print("error")
        }
    }
    
    func donePlaying() {
        print("done playing...")
    }
}

// gs_instruments.dls located at /System/Library/Components/CoreAudio.component/Contents/Resources

var completion:AVMIDIPlayerCompletionHandler =
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "MIDIPlayer_ended"), object: nil)
}


