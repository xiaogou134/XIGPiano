//
//  ViewController.swift
//  XIGPiano
//
//  Created by xiaogou134 on 2021/6/9.
//

import UIKit
import SnapKit
import AVFoundation
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController, UITableViewDelegate {
//    let relay = PublishRelay<Voice>()
    
    var pianoVoice: PianoVoice = PianoVoice.default
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
//    var dataSource: RxTableViewSectionedAnimatedDataSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WhiteTableViewCell.self, forCellReuseIdentifier: "WhiteTableViewCell")
        tableView.bounces = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pianoVoice.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteTableViewCell", for: indexPath) as! WhiteTableViewCell
        cell.firstBlackVoice = pianoVoice[black: indexPath.row * 2]
        
        cell.secondBlackVoice = pianoVoice[black: indexPath.row * 2 + 1]
        
        cell.whiteVoice = pianoVoice[white: indexPath.row]
        
        return cell
    }
}
