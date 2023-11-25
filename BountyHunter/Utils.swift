//
//  Utils.swift
//  BountyHunter
//
//  Created by Ángel González on 17/11/23.
//

import Foundation
import UIKit
import CryptoKit

public let colorPrimaryDark:UInt = 0x0005C5
public let colorAccent:UInt = 0xDFEFFF
public let regularFont:String = "MyriadPro-Regular"

class Utils {
    static func createButton (_ title:String, color:UIColor) -> UIButton {
        let boton = UIButton(type: .custom)
        boton.backgroundColor = color
        boton.setTitle(title, for:.normal)
        boton.layer.cornerRadius = 7.5
        return boton
    }
    
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func showMessage(_ message:String) {
         let ac = UIAlertController(title: "", message:message, preferredStyle:.alert)
         let aa = UIAlertAction(title: "ok", style:.default, handler: nil)
         ac.addAction(aa)
         for w in UIApplication.shared.windows {
             if w.isKeyWindow {
                 DispatchQueue.main.async {
                     w.rootViewController?.present(ac, animated: true)
                 }
                 break;
             }
         }
     }
    
    class func encryptPassword(password: String) -> String {
        let salt = ""
        let saltedPassword = password + salt

        guard let saltedPasswordData = saltedPassword.data(using: .utf8) else {
            return ""
        }
        let hashedPassword = SHA256.hash(data: saltedPasswordData)
        let hashedPasswordString = hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
        return hashedPasswordString
    }
}

extension UITextField {
    func customize(_ transparent:Bool) {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5;
        self.layer.borderColor = Utils.UIColorFromRGB(rgbValue: colorAccent).cgColor
        self.backgroundColor = .white
        self.font = UIFont(name: regularFont, size: 16)
        self.textColor = Utils.UIColorFromRGB(rgbValue: colorPrimaryDark)
        if transparent {
            self.backgroundColor = .clear
            self.layer.borderColor = Utils.UIColorFromRGB(rgbValue: colorPrimaryDark).cgColor
            self.textColor = Utils.UIColorFromRGB(rgbValue: colorAccent)
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
