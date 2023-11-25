//
//  LoginInterface.swift
//  BountyHunter
//
//  Created by Ángel González on 24/11/23.
//

import UIKit

class LoginInterface: UIViewController {
    
    let actInd = UIActivityIndicatorView()
    
    func detectStatus() -> Bool {
        // si la llave existe...
        if let _ = UserDefaults.standard.object(forKey: "UID") {
            // obtenemos el valor entero
            if ((UserDefaults.standard.object(forKey: "UID") as? Int) != nil) {
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if detectStatus() {
            self.performSegue(withIdentifier: "loginOK", sender:nil)
        }
        else {
            let loginVC = CustomLoginViewController()
            self.addChild(loginVC)
            loginVC.view.frame = self.view.bounds
            self.view.addSubview(loginVC.view)
            actInd.style = .large
            actInd.tintColor = .red
            actInd.hidesWhenStopped = true
            actInd.center = self.view.center
            self.view.addSubview(actInd)
        }
    }
    
    func customLogin (mail:String, password:String) {
        actInd.startAnimating()
        APIService().loginService(user:mail, password:password) { dictionary in
            DispatchQueue.main.async {
                self.actInd.stopAnimating()
            }
            print (dictionary)
            // si el diccionario contiene la llave code con el valor 200, entonces guardar el valor de la llave "uid"
            guard let code = dictionary?["code"] as? Int,
                  let msg = dictionary?["message"] as? String
            else {
                Utils.showMessage("There's a problem with the Server")
                return
            }
            if code == 200 {
                let uid = dictionary?["uid"] as? Int
                UserDefaults.standard.set(uid, forKey: "UID")
                UserDefaults.standard.synchronize()
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "loginOK", sender:nil)
                }
            }
            Utils.showMessage(msg)
        }
    }
    
}
