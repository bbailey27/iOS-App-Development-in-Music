//
//  FirstViewController.swift
//  MIDI Player
//
//  Created by Bridget Bailey on 2/21/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {

    var drums = MIDINote()
    var pitches = MIDINote()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drums.setPatch(num: 0, drum: true) // if you want drums ALWAYS set the patch number to 0, otherwise it might not exist
        pitches.setPatch(num: 7, drum: false) // defaulting to a ocarina
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playNoteFromTag(_ sender: UIButton) {
        
        let pitch = UInt8(sender.tag)//60=middle C, 64=mf
        if (pitch == 62) { //minor chord needs different note intervals
            pitches.sampler?.startNote(pitch, withVelocity: 64, onChannel: 0)
            pitches.sampler?.startNote(pitch + 3, withVelocity: 64, onChannel: 0)
            pitches.sampler?.startNote(pitch + 7, withVelocity: 64, onChannel: 0)
        } else {
        pitches.sampler?.startNote(pitch, withVelocity: 64, onChannel: 0)
        pitches.sampler?.startNote(pitch + 4, withVelocity: 64, onChannel: 0)
        pitches.sampler?.startNote(pitch + 7, withVelocity: 64, onChannel: 0)
        }
        
    }
    
    @IBAction func stopNoteFromTag(_ sender: UIButton) {
        
        let pitch = UInt8(sender.tag)
        if (pitch == 62) {
            pitches.sampler?.stopNote(pitch, onChannel: 0)
            pitches.sampler?.stopNote(pitch + 3, onChannel: 0)
            pitches.sampler?.stopNote(pitch + 7, onChannel: 0)
        } else {
        pitches.sampler?.stopNote(pitch, onChannel: 0)
        pitches.sampler?.stopNote(pitch + 4, onChannel: 0)
        pitches.sampler?.stopNote(pitch + 7, onChannel: 0)
        }
    }



}

