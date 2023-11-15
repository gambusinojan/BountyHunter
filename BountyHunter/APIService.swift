//
//  APIService.swift
//  BountyHunter
//
//  Created by Ángel González on 11/11/23.
//

import Foundation

let BASE_URL: String = "http://janzelaznog.com/DDAM/iOS/BountyHunter"

struct APIService {
    func getTodos(completionHandler: @escaping (Fugitives?) -> Void) {
        if let url = URL(string:"\(BASE_URL)/fugitives.json") {
            let request = URLRequest(url: url)
            let defaultSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let task = defaultSession.dataTask(with: request) { data, response, error in
                if error != nil {
                    print ("ocurrió un error \(String(describing: error))")
                    completionHandler(nil)
                    return
                }
                do {
                    let array = try JSONDecoder().decode(Fugitives.self, from: data!)
                    completionHandler(array)
                }
                catch {
                    print ("ocurrió un error \(String(describing: error))")
                    completionHandler(nil)
                }
            }
            task.resume()
        }
        else {
            completionHandler(nil)
        }
    }
    
    func getPhoto (fID:Int, completionHandler: @escaping (Data?) -> Void) {
        if let url = URL(string:"\(BASE_URL)/pics/\(fID).jpg") {
            let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, response, error in
                if error != nil {
                    completionHandler(nil)
                }
                else if let r = response as? HTTPURLResponse,
                    r.statusCode == 404 {
                    completionHandler(nil)
                }
                else {
                    completionHandler (data)
                }
            }
            task.resume()
        }
    }
}
