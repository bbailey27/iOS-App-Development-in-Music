//
//  ViewController.swift
//  EDM
//
//  Created by Bridget Bailey on 1/31/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var songs:[Song] = []
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var songSelector: UISegmentedControl!
    @IBOutlet weak var loopingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create song objects with their associated animations
        let song1 = Song("EDM.m4a", imageNames: ["BigBlue", "SmallBlue"], secondsPerBeat: 0.5455)
        let song2 = Song("connolly_Song.wav", imageNames: ["First_Swirl", "Second_Swirl", "Third_Swirl", "Fourth_Swirl"], secondsPerBeat: 0.4055)
        let song3 = Song("laible_song.m4a", imageNames: ["BigFlame", "SmallFlame"], secondsPerBeat: 0.49575)
        songs = [song1,song2,song3]
        
        //set up the animation images and interactions
        animationImageView.animationImages = song1.images //default value
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleMusic(tapGestureRecognizer:)))
        animationImageView.isUserInteractionEnabled = true
        animationImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleMusic(tapGestureRecognizer: UITapGestureRecognizer) {
        let currentSong = songs[songSelector.selectedSegmentIndex]
        // Tapping on the animation of the currently playing song will pause it
        if (currentSong.songPlayer?.isPlaying)! {
            currentSong.pause()
            animationImageView.stopAnimating()
        } else {// Selecting a new song and tapping the animation will pause the current song and play the new one
            //pause other songs to prevent overlap
            for s in songs {
                if (s != currentSong) {
                    s.pause()
                }
            }
            //switch to new song
            currentSong.play()
            animationImageView.animationImages = currentSong.images
            animationImageView.animationDuration = currentSong.animationDuration
            animationImageView.startAnimating()
            
        }
    }
    // A switch is used to toggle between looping forever and playing once
    // This applies to all songs
    @IBAction func toggleLooping(_ sender: UISwitch) {
        if loopingSwitch.isOn {
            for s in songs {
                s.songPlayer?.numberOfLoops = -1
            }
        } else {
            for s in songs {
                s.songPlayer?.numberOfLoops = 0
            }
        }
    }
    // A slider is used to control the volume of all songs
    @IBAction func changeVolumeAction(_ sender: UISlider) {
        for s in songs {
            s.setVolume(vol: volumeSlider.value)
        }
    }
    // This button stops all songs, rewinding them to the beginnings
    @IBAction func stopAllMusicAction(_ sender: UIButton) {
        for s in songs {
            s.stop()
        }
        animationImageView.stopAnimating()
    }
    
}
