//
//  AudioPlayer.swift
//  ReceptionForLinkup
//
//  Created by 中出翔也 on 2022/08/12.
//

import Foundation

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String , type :String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            print("audio susccess! ")
        }catch{
            print("音源がありません")
        }
    }
}
