//
//  MIDINote.swift
//  MIDINoteDemo
//
//  Created by Brian Moore on 2/16/17.
//  Copyright © 2017 Brian Moore. All rights reserved.
//
// This class uses the AVAudioUnitSampler (which is a subset of AVAudioUnitMIDIInstrument) to provide realtime use of MIDI events in an app including noteOn, noteOff, patch changes, controller changes (i.e. volume, panning). In this example, the sampler gets its sound from a soundfont added to the app by you the developer


import UIKit
import AVFoundation

class MIDINote: NSObject {
    
    var engine:AVAudioEngine? // the most top level of the audio system - our sampler will 'connect' to this engine
    var soundbank:URL? // this will reference a soundfont added to the app
    var sampler:AVAudioUnitSampler? // see documentation also for AVAudioUnitMIDIInstrument

    
    let melodicBank = UInt8(kAUSampler_DefaultMelodicBankMSB) // an Apple provided variable to tell the sound font to use the pitched soundbank
    let drumBank = UInt8(kAUSampler_DefaultPercussionBankMSB) // an Apple provided variable used to switch to percussion/drum soundbank

    
    override init() { //initial setup of our MIDINote class to get the audioengine up and running and connected to our sampler that should use our font
        
        engine = AVAudioEngine() // 1. setup the audio engine so that we can everntually playback midi events via our soundfont
        
        soundbank = Bundle.main.url(forResource: "gs_instruments", withExtension: "dls") // 2. find out soundfont: using gs_instruments.dls located at /System/Library/Components/CoreAudio.component/Contents/Resources
        
        sampler = AVAudioUnitSampler()
        
        engine?.attach(sampler!) 
        engine?.connect(sampler!, to: (engine?.mainMixerNode)!, format: nil)
        
        do {
            try engine?.start()
        } catch let error  {
            print(error.localizedDescription)
        }
    }
    
    func setPatch(num: Int, drum:Bool) { // to set a patch, provide a number (0-127) and true/false for drums
        let newPatch = UInt8(num)
        let bank = drum ? drumBank : melodicBank // let bank assigned by value of true/false from 'drum'
        
        do {
            try sampler?.loadSoundBankInstrument(at: soundbank!, program: newPatch, bankMSB: bank, bankLSB: 0)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
