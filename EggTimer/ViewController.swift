//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cookingProgress: UIProgressView!
    
    let eggTimes : [String : Int] = [
        "Soft": (5),
        "Medium": (7),
        "Hard": (12),
    ]
    
    var audioPlayer : AVAudioPlayer!
    var timer: Timer?
    var totalTime = 0.0
    var secondsPassed = 0.0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        cookingProgress.progress = 0.0
        
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        totalTime = Double(eggTimes[hardness]!)
        titleLabel.text = "Cooking \(hardness)..."
        /* currentTitle could be 'nil' if IBAction was linked to another button that did not have a title.
         Thus the default data type is an optional String denoted by 'String?'
         However, in this case we know that we linked the IBAction specifically to 3 buttons with titles.
         Therefore you can add an exclaimation point to currentTitle*/
        
//        print(eggTimes[hardness]!)
        /* when providing a key to a piece of text the end result will be optional because what happens if you
         try calling a dictionary key, but misspell it to have a capital when there was none or visa versa
         the result (even if every letter was the same) because of difference, the computer will not know and
         the result will be 'nil'
         Therefore add an explamation to the calling of the dictionary value using the key provided from hardness that
         we made not optional in previous line of code*/

        startTimer()
        
        
        func startTimer() {
            timer?.invalidate() // Invalidate any existing timer
            secondsPassed = 0.0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in guard let self = self else { return }
                
                if self.secondsPassed < self.totalTime {
                    self.secondsPassed += 1
                    let percentageProgress = Float(self.secondsPassed/self.totalTime)
                    self.cookingProgress.progress = percentageProgress
                } else {
                    timer.invalidate() // Stop the timer when the countdown reaches 0
                    
                    cookingProgress.progressTintColor = UIColor.systemGreen // change the progress bar to a green colour to show completion                    
                    titleLabel.text = "DONE!" // change title to show to user done cooking.

                    
                    let soundUrl = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") //Think of setting up stereo system
                    audioPlayer = try! AVAudioPlayer(contentsOf: soundUrl!) // Think of putting disc in stereo system
                    audioPlayer.play() //Think of pressing play of stereosystem with disc set up.
                }
            }
        }
//        switch hardness {
//        case "Soft":
//            print(softTime)
//        case "Medium":
//            print(mediumTime)
//        case "Hard":
//            print(hardTime)
//        default:
//            print("Error, no hardness match")
//        }
        
        //  a...b  Closed Range
        //  a..<b  Half Open Range
        //  ...b   One Sided Range
        
        
        // you can use if/else statements as below or use switch!
        // If you have more than 5 conditions --> SWITCH
        // If you have less than 5 condtions --> if/else
//        if hardness == "Soft" {
//            print(softTime)
//        } else if hardness == "Medium" {
//            print(mediumTime)
//        } else {
//            print(hardTime)
//        }
    }
    
    

}
