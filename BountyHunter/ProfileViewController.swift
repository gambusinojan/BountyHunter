//
//  ProfileViewController.swift
//  BountyHunter
//
//  Created by Ángel González on 18/11/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let btnPlay=Utils.createButton("log out", color: .lightGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let l1=UILabel()
        l1.text="Welcome to the app!"
        l1.font=UIFont.systemFont(ofSize: 24, weight: .bold)
        l1.autoresizingMask = .flexibleWidth
        l1.translatesAutoresizingMaskIntoConstraints=true
        l1.frame=CGRect(x: 0, y: 60, width: self.view.frame.width, height: 50)
        l1.textAlignment = .center
        self.view.addSubview(l1)
        self.view.addSubview(btnPlay)
        btnPlay.autoresizingMask = .flexibleWidth
        btnPlay.translatesAutoresizingMaskIntoConstraints=true
        let viewH = self.view.bounds.height
        btnPlay.frame=CGRect(x: 0, y:viewH - 120, width: 100, height: 40)
        btnPlay.center.x = self.view.center.x
        let avpp = AVPlayerPlayer()
        self.view.addSubview(avpp.view)
        avpp.view.translatesAutoresizingMaskIntoConstraints = false
        avpp.view.topAnchor.constraint(equalTo:l1.bottomAnchor, constant: 20).isActive = true
        avpp.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        avpp.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        avpp.view.heightAnchor.constraint(equalToConstant:320).isActive = true
        self.addChild(avpp)
    }
}
        
