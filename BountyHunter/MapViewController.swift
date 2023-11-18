//
//  MapViewController.swift
//  BountyHunter
//
//  Created by Ángel González on 17/11/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var elMapa = MKMapView()
    var fugitive: Fugitive?
    var header = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elMapa.frame = self.view.bounds.insetBy(dx: 10, dy: 140)
        self.view.addSubview(elMapa)
        self.view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fugitive != nil {
            let centro = CLLocationCoordinate2D(latitude:fugitive!.lastSeenLat, longitude:fugitive!.lastSeenLon)
            elMapa.setRegion(MKCoordinateRegion(center:centro, latitudinalMeters:500, longitudinalMeters:500), animated: true)
            let elPin = MKPointAnnotation()
            elPin.coordinate = centro
            elPin.title = "El fugitivo está aqui"
            elMapa.addAnnotation(elPin)
            header.text = fugitive!.name
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude:fugitive!.lastSeenLat, longitude:fugitive!.lastSeenLon)) { lugares, error in
                if error != nil {
                    print ("ocurrio un error en la geolocalizacion \(String(describing: error))")
                }
                else {
                    guard let lugar = lugares?.first else { return }
                    let thoroughfare = (lugar.thoroughfare ?? "")
                    let subThoroughfare = (lugar.subThoroughfare ?? "")
                    let locality = (lugar.locality ?? "")
                    let subLocality = (lugar.subLocality ?? "")
                    let administrativeArea = (lugar.administrativeArea ?? "")
                    let subAdministrativeArea = (lugar.subAdministrativeArea ?? "")
                    let postalCode = (lugar.postalCode ?? "")
                    let country = (lugar.country ?? "")
                    let direccion = "\nVisto por última vez en: \(thoroughfare) \(subThoroughfare) \(locality) \(subLocality) \(administrativeArea) \(subAdministrativeArea) \(postalCode) \(country)"
                    DispatchQueue.main.async {
                        self.header.text += direccion
                    }
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
