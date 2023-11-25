//
//  LoginInterface.swift
//  BountyHunter
//
//  Created by Ángel González on 24/11/23.
//

import UIKit
import AuthenticationServices

class LoginInterface: UIViewController, ASAuthorizationControllerDelegate {
    
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
            self.view.backgroundColor = .red.withAlphaComponent(0.4)
            loginVC.view.frame = CGRect(x: 0, y: 40, width:self.view.bounds.width, height:self.view.bounds.width)
            self.view.addSubview(loginVC.view)
            actInd.style = .large
            actInd.tintColor = .red
            actInd.hidesWhenStopped = true
            actInd.center = self.view.center
            self.view.addSubview(actInd)
            // agregamos el boton de appleID
            let appleIDBtn = ASAuthorizationAppleIDButton()
            self.view.addSubview(appleIDBtn)
            appleIDBtn.frame.origin.y = loginVC.view.frame.maxY + 20
            appleIDBtn.center.x = self.view.center.x
            appleIDBtn.addTarget(self, action:#selector(appleIDBtnTouch), for:.touchUpInside)
        }
    }
    
    @objc func appleIDBtnTouch(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.delegate = self
        authController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credentials = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = credentials.user
            let name = credentials.fullName
            let mail = credentials.email
            // todo OK TODO: registrar al usuario en mi backend
            // y avanzar a home
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print (error.localizedDescription)
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
