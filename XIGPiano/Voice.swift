//
//  pianoVoice.swift
//  XIGPiano
//
//  Created by xiaogou134 on 2021/6/9.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import AVFoundation

enum voiceTone {
    case whiteKey(FullTone)
    case blackKey(HalfTone)
    
    var toneString: String {
        switch self {
        case let .whiteKey(fullTone):
            return fullTone.rawValue
        case let .blackKey(halfTone):
            return halfTone.rawValue
        }
    }
}

protocol Tone {
    var toneVoice: String { get }
}

enum FullTone: String, CaseIterable, Tone {
    case toneA = "A"
    case toneB = "B"
        
    case aToneC = "C-2"
    case aToneD = "D-2"
    case aToneE = "E-2"
    case aToneF = "F-2"
    case aToneG = "G-2"
    case aToneA = "A-2"
    case aToneB = "B-2"
    
    case bToneC = "C-1"
    case bToneD = "D-1"
    case bToneE = "E-1"
    case bToneF = "F-1"
    case bToneG = "G-1"
    case bToneA = "A-1"
    case bToneB = "B-1"
    
    case cToneC = "C0"
    case cToneD = "D0"
    case cToneE = "E0"
    case cToneF = "F0"
    case cToneG = "G0"
    case cToneA = "A0"
    case cToneB = "B0"
    
    case dToneC = "C1"
    case dToneD = "D1"
    case dToneE = "E1"
    case dToneF = "F1"
    case dToneG = "G1"
    case dToneA = "A1"
    case dToneB = "B1"
    
    case eToneC = "C2"
    case eToneD = "D2"
    case eToneE = "E2"
    case eToneF = "F2"
    case eToneG = "G2"
    case eToneA = "A2"
    case eToneB = "B2"
    
    case fToneC = "C3"
    case fToneD = "D3"
    case fToneE = "E3"
    case fToneF = "F3"
    case fToneG = "G3"
    case fToneA = "A3"
    case fToneB = "B3"
    
    case gToneC = "C4"
    case gToneD = "D4"
    case gToneE = "E4"
    case gToneF = "F4"
    case gToneG = "G4"
    case gToneA = "A4"
    case gToneB = "B4"
    
    case toneC = "C"
    
    var toneVoice: String {
        return self.rawValue
    }
}


enum HalfTone: String, CaseIterable, Tone {
    case halfToneA = "A#"
    
    case ahalfToneC = "C#-2"
    case ahalfToneD = "D#-2"
    case ahalfToneF = "F#-2"
    case ahalfToneG = "G#-2"
    case ahalfToneA = "A#-2"
    
    case bhalfToneC = "C#-1"
    case bhalfToneD = "D#-1"
    case bhalfToneF = "F#-1"
    case bhalfToneG = "G#-1"
    case bhalfToneA = "A#-1"
    
    case chalfToneC = "C#0"
    case chalfToneD = "D#0"
    case chalfToneF = "F#0"
    case chalfToneG = "G#0"
    case chalfToneA = "A#0"
    
    case dhalfToneC = "C#1"
    case dhalfToneD = "D#1"
    case dhalfToneF = "F#1"
    case dhalfToneG = "G#1"
    case dhalfToneA = "A#1"
    
    case ehalfToneC = "C#2"
    case ehalfToneD = "D#2"
    case ehalfToneF = "F#2"
    case ehalfToneG = "G#2"
    case ehalfToneA = "A#2"
    
    case fhalfToneC = "C#3"
    case fhalfToneD = "D#3"
    case fhalfToneF = "F#3"
    case fhalfToneG = "G#3"
    case fhalfToneA = "A#3"

    case ghalfToneC = "C#4"
    case ghalfToneD = "D#4"
    case ghalfToneF = "F#4"
    case ghalfToneG = "G#4"
    case ghalfToneA = "A#4"
    
    var toneVoice: String {
        return self.rawValue
    }
}

class Voice: Equatable {
    var tone: Tone
    var avPlayer: AVAudioPlayer?
    
    init(tone: Tone) {
        self.tone = tone
    }
    
    func loadVoice() {
        guard let voiceURL = Bundle.main.url(forResource: tone.toneVoice, withExtension: "mp3") else { return }
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        try? audioSession.setCategory(.playback)
        
        avPlayer = try? AVAudioPlayer(contentsOf: voiceURL)
        avPlayer?.prepareToPlay()
        avPlayer?.play()

    }

    static func == (lhs: Voice, rhs: Voice) -> Bool {
        if lhs.tone.toneVoice == rhs.tone.toneVoice {
            return true
        } else {
            return false
        }
    }
    
}
