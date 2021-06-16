//
//  PianoVoice.swift
//  XIGPiano
//
//  Created by xiaogou134 on 2021/6/10.
//

import Foundation
import RxDataSources

class PianoVoice {
    static let `default` = PianoVoice()
    private let aGroupTone = ["C", "D", "E", "F", "G", "A", "B"]
    
    private var whiteVoiceGroup: [Voice] = []
    private var blackVoiceGroup: [Voice?] = []
    
    var count: Int
    
    init() {
        var whiteToneGroup: [FullTone] = []
        var blackToneGroup: [HalfTone?] = []
        
        whiteToneGroup += [FullTone.toneA, .aToneB]
        blackToneGroup += [nil, .halfToneA, .halfToneA, nil]
        
        for i in -2..<4 {
            whiteToneGroup += aGroupTone.map{ FullTone(rawValue: $0 + "\(i)")! }
            var blackTemple = aGroupTone.flatMap{ [HalfTone(rawValue: $0 + "#" + "\(i)"), HalfTone(rawValue: $0 + "#" + "\(i)")]}
            blackTemple.removeLast()
            blackTemple.insert(nil, at: 0)
            blackToneGroup += blackTemple
        }
        whiteToneGroup.append(.toneC)
        blackToneGroup += [nil, nil]
        
        whiteVoiceGroup = whiteToneGroup.map{ Voice(tone: $0) }
        blackVoiceGroup = blackToneGroup.map{
            guard let tone = $0 else { return nil }
            return Voice(tone: tone)
        }
        count = whiteToneGroup.count
    }
    
    subscript(white i: Int) -> Voice {
        return whiteVoiceGroup[i]
    }
    
    subscript(black i: Int) -> Voice? {
        return blackVoiceGroup[i]
    }
}

struct SectionOfPianoVoice {
    var items: [Item]
}

extension SectionOfPianoVoice: SectionModelType {
    typealias Item = Voice
    
    init(original: SectionOfPianoVoice, items: [Voice]) {
        self = original
        self.items = items
    }
}
