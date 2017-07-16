//
//  ViewController.swift
//  MIDINoteDemo
//
//  Created by Bridget Bailey
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    var instrument = MIDINote()
    
    @IBOutlet var noteLabels: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instrument.setPatch(num: 75, drum: false) // pan flute
        //good instruments: tubular bells, pan flute, steel drums
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playNoteFromTag(_ sender: UIButton) {
        
        let pitch = UInt8(sender.tag)
        
        instrument.sampler?.startNote(pitch, withVelocity: 90, onChannel: 0)
    }
    
    @IBAction func stopNoteFromTag(_ sender: UIButton) {
        
        let pitch = UInt8(sender.tag)

        instrument.sampler?.stopNote(pitch, onChannel: 0)
    }
    
    @IBAction func toggleNoteNameLabels(_ sender: UISwitch) {
        for label in noteLabels {
            label.isHidden = !label.isHidden
        }
    }
}

