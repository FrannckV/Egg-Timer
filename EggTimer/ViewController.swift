//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var progressTimer: UIProgressView!
    var player: AVAudioPlayer!
    
    let eggTimes = [ "Soft": 3 , "Medium" : 4, "Hard" : 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        progressTimer.progress = 0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        labelTitle.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressTimer.progress = Float(secondsPassed)/Float(totalTime)
        }   else {
            timer.invalidate()
            labelTitle.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
