//
//  ViewController.swift
//  MIDINoteDemo
//
//  Created by Brian Moore on 2/16/17.
//  Copyright © 2017 Brian Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var demo_drums = MIDINote()
    var demo_pitches = MIDINote()
    //var demo_pitches2 = MIDINote()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        demo_drums.setPatch(num: 0, drum: true) // if you want drums ALWAYS set the patch number to 0
        demo_pitches.setPatch(num: 114, drum: false) // defaulting to a kalimba
        //demo_pitches2.setPatch(num: 14, drum: false)
        //tubular bells, pan flute, steel drums
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playNoteFromTag(_ sender: UIButton) {
        
        let pitch = UInt8(sender.tag)
        
        //demo_drums.sampler?.startNote(pitch, withVelocity: 127, onChannel: 1)
        
        demo_pitches.sampler?.startNote(pitch, withVelocity: 90, onChannel: 0)
        //demo_pitches2.sampler?.startNote(pitch, withVelocity: 90, onChannel: 0)
        //demo_pitches.sampler?.startNote(pitch + 4, withVelocity: 90, onChannel: 0)
        //demo_pitches.sampler?.startNote(pitch + 7, withVelocity: 90, onChannel: 0)
    }
    
    @IBAction func stopNoteFromTag(_ sender: UIButton) {
        
        let pitch = UInt8(sender.tag)
        
        demo_drums.sampler?.stopNote(pitch, onChannel: 1)
        //
        demo_pitches.sampler?.stopNote(pitch, onChannel: 0)
        //demo_pitches2.sampler?.stopNote(pitch - 12, onChannel: 0)
        //        demo_pitches.sampler?.stopNote(pitch + 3, onChannel: 0)
        //        demo_pitches.sampler?.stopNote(pitch + 5, onChannel: 0)
        //        demo_pitches.sampler?.stopNote(pitch - 3, onChannel: 0)
    }
}

