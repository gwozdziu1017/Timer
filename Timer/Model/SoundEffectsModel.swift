//
//  SoundEffectsModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 30/10/2025.
//

import AVFoundation
import AudioToolbox

struct SoundEffects {
    let countdownSound: SystemSoundID = 1113
    let countdownFinishedSound: SystemSoundID = 1256

    static func playCountdownSound() {
        AudioServicesPlaySystemSound(SoundEffects().countdownSound)
    }
    static func playCountdownFinishedSound() {
        AudioServicesPlaySystemSound(SoundEffects().countdownFinishedSound)
    }
}
