//
//  LoginInterface.swift
//  BountyHunter
//
//  Created by Ángel González on 24/11/23.
//

import UIKit

class LoginInterface: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginVC = CustomLoginViewController()
        self.addChild(loginVC)
        loginVC.view.frame = self.view.bounds
        self.view.addSubview(loginVC.view)
    }
    
    func customLogin (mail:String, password:String) {
        APIService().loginService(user:mail, password:password) { dictionary in
            print (dictionary)
        }
    }
    
}
