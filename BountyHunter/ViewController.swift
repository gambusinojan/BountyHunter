//
//  ViewController.swift
//  BountyHunter
//
//  Created by Ángel González on 11/11/23.
//

import UIKit

// UIImagePickerControllerDelegate & UINavigationControllerDelegate se requieren para la implementacion del imagePicker
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var fugitive : Fugitive?
    let tv = UITextView()
    let iv = UIImageView()
    let apiS = APIService()
    
    let imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        // Do any additional setup after loading the view.
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tv)
        tv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-50).isActive = true
        tv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:25).isActive = true
        tv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-25).isActive = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "life")
        self.view.addSubview(iv)
        iv.topAnchor.constraint(equalTo: self.view.topAnchor, constant:150).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        iv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:25).isActive = true
        iv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-25).isActive = true
        let boton = UIButton(type: .custom)
        boton.backgroundColor = .lightGray.withAlphaComponent(0.5)
        boton.setTitle("actualizar foto", for:.normal)
        boton.layer.cornerRadius = 7.5
        self.view.addSubview(boton)
        // configuramos sus constraints
        boton.translatesAutoresizingMaskIntoConstraints = false
        boton.widthAnchor.constraint(equalToConstant:150).isActive = true
        boton.heightAnchor.constraint(equalToConstant:45).isActive = true
        boton.centerXAnchor.constraint(equalTo:iv.centerXAnchor).isActive = true
        boton.centerYAnchor.constraint(equalTo:iv.centerYAnchor).isActive = true
        // le asignamos un action para cuando el usuario lo toque
        boton.addTarget(self, action:#selector(botonTouch), for:.touchUpInside)
    }

    @objc func botonTouch() {
        // si se permite la edición....
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true)
    }
    
    // cuando el usuario elige una foto, la colocamos en lugar de la actual
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // ... si se permitió la edición hay que buscar la foto como editada
        if let imagen = info[.editedImage] as? UIImage {
        // si no se permitió la edición, la imagen está en la llave
        // if let imagen = info[.originalImage] as? UIImage {
            self.iv.image = imagen
        }
        imagepicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagepicker.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fugitive != nil {
            let info = "NOMBRE: \(fugitive!.name)\nDELITO:\(fugitive!.desc)\nRECOMPENSA: \(fugitive!.bounty)"
            tv.text = info
            // descargar la foto de <URL>/pics/<FUGITIVE_ID>.jpg
            apiS.getPhoto(fID: fugitive!.fugitiveid) { data in
                if let d = data {
                    DispatchQueue.main.async {
                        let photo = UIImage(data:d)
                        self.iv.image = photo
                    }
                }
            }
        }
    }

}

