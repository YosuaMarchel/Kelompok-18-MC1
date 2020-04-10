//
//  HomeVC.swift
//  Kelompok 18 MC1 Napp
//
//  Created by Yosua Marchel on 07/04/20.
//  Copyright © 2020 Yosua Marchel. All rights reserved.
//

import UIKit
import AVFoundation

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
    @IBOutlet weak var timerBackgroundImage: UIImageView!
    
    
    //for Timer
    var seconds: Int64 = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    //progress bar
    var progress = Progress(totalUnitCount: 0)
    var totalTime : Int64 = 0
    
    //for Music
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextLabel.text = "Ready to nap?"
        timerLabel.text = "Get into a comfortable spot before we start."
        timerLabel.font = timerLabel.font.withSize(21)
        nappyImage.image = UIImage(named: "NappyRevisi-1")
        timerBackgroundImage.layer.cornerRadius = 20
        
        //progress bar
        timerProgress.transform = timerProgress.transform.scaledBy(x: 1, y: 3)
        timerProgress.isHidden = true
        
        //slider
        slider.isHidden = false
        
        //buttons
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        resumeButton.isHidden = true
        resetButton.isHidden = true
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        let currentValue = Int64(sender.value) * 60
        seconds = currentValue
        timerLabel.text = timeString(time: TimeInterval(seconds))
        topTextLabel.text = "Set the timer"
        nappyImage.image = UIImage(named: "NappyRevisi-8")
        timerLabel.font = timerLabel.font.withSize(36)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        totalTime = seconds
        if seconds == 0 {
            showAlertTimerNotSet()
        }else{
            timerProgress.isHidden = false
            slider.isHidden = true
            startButton.isEnabled = false
            startButton.isHidden = true
            topTextLabel.text = "Take a nap"
            nappyImage.image = UIImage(named: "NappyRevisi-5")
            if isTimerRunning == false {
                self.progress = Progress(totalUnitCount: totalTime)
                timerProgress.progress = 0.0
                self.progress.completedUnitCount = 0
                runTimer()
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
            resumeButton.isEnabled = true
            resetButton.isHidden = false
            pauseButton.isHidden = true
            nappyImage.image = UIImage(named: "NappyRevisi-8")
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
        seconds = 0
        slider.value = 0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        resumeTapped = false
        topTextLabel.text = "Ready to nap?"
        timerLabel.text = "Get into a comfortable spot before we start."
        timerLabel.font = timerLabel.font.withSize(21)
        nappyImage.image = UIImage(named: "NappyRevisi-1")
        audioPlayer.stop()
        
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
            nappyImage.image = UIImage(named: "NappyRevisi-6")
            topTextLabel.text = "Time's up!"
            
            //Send alert to indicate "time's up!"
            showAlertTimesUp()
            
            //play alarm sound
            let path = Bundle.main.path(forResource: "bensound-creativeminds", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: url)
            } catch {
                print("error")
            }
            audioPlayer.play()
            
            //set button
            pauseButton.isHidden = true
            resumeButton.isHidden = false
            resumeButton.isEnabled = false
            resetButton.isHidden = false
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            
            //progress bar
            self.progress.completedUnitCount = progress.totalUnitCount - seconds
            self.timerProgress.setProgress(Float(self.progress.fractionCompleted), animated: true)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    //allert setting
    func showAlertTimerNotSet() {
        let alert = UIAlertController(title: "Message", message: "Please set the timer", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertTimesUp() {
        let alert = UIAlertController(title: "Message", message: "Come on wake up!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
