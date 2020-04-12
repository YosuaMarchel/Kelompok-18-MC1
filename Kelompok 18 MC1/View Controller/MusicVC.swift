//
//  MusicVC.swift
//  Kelompok 18 MC1
//
//  Created by Yosua Marchel on 09/04/20.
//  Copyright © 2020 Yosua Marchel. All rights reserved.
//

import UIKit
import AVFoundation

protocol ChooseSongDelegate {
    func chooseSong(title: String)
}

class MusicVC: UIViewController {
        
    var delegate: ChooseSongDelegate?
    
    //for Music
    var audioPlayer = AVAudioPlayer()
    var choosenTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playAndStopMusic(_ sender: UIButton) {
        switch sender.accessibilityIdentifier {
        case "music1Button":
            addMusic(title: "bensound-summer")
            audioPlayer.play()
            choosenTitle = "bensound-summer"
        case "music2Button":
            addMusic(title: "bensound-ukulele")
            audioPlayer.play()
            choosenTitle = "bensound-ukulele"
        case "music3Button":
            addMusic(title: "bensound-creativeminds")
            audioPlayer.play()
            choosenTitle = "bensound-creativeminds"
        case "musicOffButton":
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            choosenTitle = ""
        default:
            choosenTitle = ""
        }
        
        
    }
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        let title = choosenTitle
        delegate?.chooseSong(title: title)
        //dismiss(animated: true, completion: nil)
    }
    
    func addMusic (title: String){
        let path = Bundle.main.path(forResource: title, ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: url)
        } catch {
            // can't load file
        }
    }
    
}
