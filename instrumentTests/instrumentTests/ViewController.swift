//
//  ViewController.swift
//  instrumentTests
//
//  Created by Bridget Bailey on 3/2/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreAudio
import AudioKit

class ViewController: UIViewController {
    
    var mic:AKMicrophone?
    var tracker:AKFrequencyTracker?
    var silence:AKBooster?
    var myTimer: Timer?
    
    
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var amplitudeLabel: UILabel!
    @IBOutlet weak var noteNameWithSharpsLabel: UILabel!
    @IBOutlet weak var noteNameWithFlatsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mic = AKMicrophone()
        tracker = AKFrequencyTracker.init(mic!)
        silence = AKBooster(tracker!, gain: 0)
        AudioKit.output = silence
        AudioKit.start()
        tracker?.start()
        
        myTimer = Timer(timeInterval: 0.1, target: self, selector:#selector(ViewController.updateUI), userInfo: nil, repeats: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI() {
        if tracker!.amplitude > 0.1 {
            frequencyLabel.text = String(format: "%0.1f", (tracker?.frequency)!)
            
            var frequency = Float(tracker!.frequency)
            //while (frequency > Float(noteFrequencies[noteFrequencies.count-1])) {
              //  frequency = frequency / 2.0
            //}
            //while (frequency < Float(noteFrequencies[0])) {
              //  frequency = frequency * 2.0
            //}
            
            var minDistance: Float = 10000.0
            var index = 0
            
            //for i in 0..<noteFrequencies.count {
              //  let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                //if (distance < minDistance){
                  //  index = i
                    //minDistance = distance
                //}
            //}
            //let octave = Int(log2f(Float(tracker?.frequency) / frequency))
            //noteNameWithSharpsLabel.text = "\(noteNamesWithSharps[index])\(octave)"
            //noteNameWithFlatsLabel.text = "\(noteNamesWithFlats[index])\(octave)"
        }
        amplitudeLabel.text = String(format: "%0.2f", (tracker?.amplitude)!)
    }
    
}
