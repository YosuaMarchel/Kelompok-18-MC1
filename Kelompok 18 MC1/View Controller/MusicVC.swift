//
//  MusicVC.swift
//  Kelompok 18 MC1
//
//  Created by Yosua Marchel on 09/04/20.
//  Copyright © 2020 Yosua Marchel. All rights reserved.
//

import UIKit
import AVFoundation

class MusicVC: UIViewController {
    
    //for Music
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playAndStopMusic(_ sender: UIButton) {
        switch sender.accessibilityIdentifier {
        case "music1Button":
            let path = Bundle.main.path(forResource: "bensound-summer", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: url)
            } catch {
                // can't load file
            }
            audioPlayer.play()
        case "music2Button":
            let path = Bundle.main.path(forResource: "bensound-ukulele", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: url)
            } catch {
                // can't load file
            }
            audioPlayer.play()
        case "music3Button":
            let path = Bundle.main.path(forResource: "bensound-creativeminds", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: url)
            } catch {
                // can't load file
            }
            audioPlayer.play()
        case "musicOffButton":
            audioPlayer.stop()
            audioPlayer.currentTime = 0
        default:
            print("no music")
        }
        
        
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
