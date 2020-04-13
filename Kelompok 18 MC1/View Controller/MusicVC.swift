//
//  MusicVC.swift
//  Kelompok 18 MC1
//
//  Created by Yosua Marchel on 09/04/20.
//  Copyright © 2020 Yosua Marchel. All rights reserved.
//

import UIKit
import AVFoundation

//for undwind music data
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
            addMusic(title: "Music1")
            audioPlayer.play()
            choosenTitle = "Music1"
        case "music2Button":
            addMusic(title: "Music2")
            audioPlayer.play()
            choosenTitle = "Music2"
        case "music3Button":
            addMusic(title: "Music3")
            audioPlayer.play()
            choosenTitle = "Music3"
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
