//
//  BlackKeyView.swift
//  XIGPiano
//
//  Created by xiaogou134 on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa

class BlackKeyButton: UIButton {
    static let voiceRelay = PublishRelay<Voice>()
    
    var voice: Voice? {
        didSet {
            isHidden = (voice == nil) 
        }
    }
    let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBinding() {
        rx.controlEvent(.touchUpInside).subscribe{ [weak self] _ in
            guard let self = self,
                  let voice = self.voice else { return }
            voice.loadVoice()
            BlackKeyButton.voiceRelay.accept(voice)
        }.disposed(by: disposeBag)
        
        BlackKeyButton.voiceRelay.filter{ [weak self]  in $0 == self?.voice }.subscribe{
            [weak self] _ in
            guard let self = self else { return }
            self.tapAnimation()
        }.disposed(by: disposeBag)
    }
    
    func tapAnimation() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.black.withAlphaComponent(0.5).cgColor
        animation.toValue = UIColor.black.cgColor
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        layer.add(animation, forKey: "backgroundColor")
       
    }
}
