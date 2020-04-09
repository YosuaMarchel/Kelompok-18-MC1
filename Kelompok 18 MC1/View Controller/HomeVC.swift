//
//  HomeVC.swift
//  Kelompok 18 MC1 Napp
//
//  Created by Yosua Marchel on 07/04/20.
//  Copyright © 2020 Yosua Marchel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var nappyImage: UIImageView!
    
    //for Timer
    var seconds: Int64 = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    var progress = Progress(totalUnitCount: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.layer.cornerRadius = 20
        topTextLabel.text = "Set the timer"
        
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        resumeButton.isHidden = true
        slider.isHidden = false
        timerProgress.isHidden = true
        resetButton.isHidden = true
        
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        //        let currentValue = Int(sender.value)
        
        let currentValue = Int64(sender.value) * 60
        seconds = currentValue
        timerLabel.text = timeString(time: TimeInterval(seconds))
        
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timerProgress.isHidden = false
        slider.isHidden = true
        startButton.isEnabled = false
        startButton.isHidden = true
        topTextLabel.text = "Take a nap"
        nappyImage.image = UIImage(named: "NappyRevisi-5")
        
        if isTimerRunning == false {
            runTimer()
            
            //progress bar setting
            self.progress = Progress(totalUnitCount: seconds)
            timerProgress.progress = 0.0
            self.progress.completedUnitCount = 0
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                guard self.progress.isFinished == false else {
                    timer.invalidate()
                    return
                }
                self.progress.completedUnitCount += 1
                self.timerProgress.setProgress(Float(self.progress.fractionCompleted), animated: true)
            }
        }
        
        slider.value = Float(seconds)/60
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(HomeVC.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
        pauseButton.isHidden = false
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            resumeButton.isHidden = false
            resetButton.isHidden = false
            pauseButton.isHidden = true
            nappyImage.image = UIImage(named: "NappyRevisi-6")
        }
    }
    @IBAction func resumeButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == true {
            runTimer()
            self.resumeTapped = false
            resumeButton.isHidden = true
            resetButton.isHidden = true
            pauseButton.isHidden = false
            nappyImage.image = UIImage(named: "NappyRevisi-5")
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = Int64(slider.value) * 60
        timerLabel.text = timeString(time: TimeInterval(slider.value * 60))
        isTimerRunning = false
        resumeTapped = false
        topTextLabel.text = "Set the timer"
        nappyImage.image = UIImage(named: "NappyRevisi-8")
        
        //timer progress reset
        timerProgress.progress = 0.0
        self.progress.completedUnitCount = 0
        
        //button, slider, label setting
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        startButton.isEnabled = true
        startButton.isHidden = false
        resetButton.isHidden = true
        resumeButton.isHidden = true
        slider.isHidden = false
        timerProgress.isHidden = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate "time's up!"
            nappyImage.image = UIImage(named: "NappyRevisi-6")
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}
