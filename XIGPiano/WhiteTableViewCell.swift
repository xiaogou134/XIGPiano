//
//  WhiteTableViewCell.swift
//  XIGPiano
//
//  Created by xiaogou134 on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa

class WhiteTableViewCell: UITableViewCell {
    var firstBlackVoice: Voice? {
        didSet {
            firstView.voice = firstBlackVoice
        }
    }

    var secondBlackVoice: Voice? {
        didSet {
            secondView.voice = secondBlackVoice
            separatorLine.isHidden = !(secondBlackVoice == nil)
        }
    }
    
    var whiteVoice: Voice?
    let firstView = BlackKeyButton()
    let secondView =  BlackKeyButton()
    let aniLayer: CAShapeLayer
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var secSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        aniLayer = CAShapeLayer()
        aniLayer.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.insertSublayer(aniLayer, at: 0)
        
        selectionStyle = .gray
        backgroundColor = .white
        contentView.addSubview(firstView)
        firstView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        contentView.addSubview(secondView)
        secondView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.leading.equalToSuperview()
            make.trailing.bottom.equalToSuperview()
        }
        
        addSubview(secSeparatorLine)
        secSeparatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.leading.equalTo(secondView.snp.trailing)
            make.trailing.bottom.equalToSuperview()
        }
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(touchWhite))
        addGestureRecognizer(ges)
    }
    
    @objc func touchWhite() {
        guard let whiteVoice = whiteVoice else { return }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        if secondView.isHidden {
            path.addLine(to: CGPoint(x: 0, y: bounds.height))
        } else {
            path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
            path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height * 0.7))
            path.addLine(to: CGPoint(x: 0, y: bounds.height * 0.7))
        }

        if firstView.isHidden {
            path.addLine(to: CGPoint(x: 0, y: 0))
        } else {
            path.addLine(to: CGPoint(x: 0, y: bounds.height * 0.3))
            path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height * 0.3))
            path.addLine(to: CGPoint(x: bounds.width / 2, y: 0.3))
        }
        path.close()
        path.lineWidth = 1
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        aniLayer.path = path.cgPath
        aniLayer.add(animation, forKey: "opacity")
        
//        aniLayer.strokeColor = UIColor.white.cgColor
        
        whiteVoice.loadVoice()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


