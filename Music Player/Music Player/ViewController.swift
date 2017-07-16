//
//  ViewController.swift
//  Music Player
//
//  Created by Bridget Bailey on 2/7/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var song = MusicPlayer(fileName: "EDM", fileExtension: "m4a")


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func musicTransport(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0: // play
            song.play()
        case 1: // pause
            song.pause()
        case 2: // stop
            song.stop()
        default:
            print("somehow we have an error")
        }
    }

}

