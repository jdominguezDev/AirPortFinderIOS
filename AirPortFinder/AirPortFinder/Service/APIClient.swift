//
//  APIClient.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 25/08/22.
//

import Foundation

typealias ItemAirport = [ItemAirportElement]

final class APIClient {
    func getAirports(latitud : String, longitud : String, radio : String, completionBlock: @escaping (ItemAirport) -> ()) {
        let url = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=" + latitud + "&lon=" + longitud + "&radius=" + radio + "&rapidapi-key=784f1eda9amshe378e0999e4c745p1e2442jsn654e70901ac2")!
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            let dataModel = try! JSONDecoder().decode(ItemAirport.self, from: data!)
            completionBlock(dataModel)
            
            
        }
        task.resume()
    }
    
    func getLista(latitud : String, longitud : String, radio : String) -> ItemAirport? {
        
        let session = URLSession.shared
        let url = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=" + latitud + "&lon=" + longitud + "&radius=" + radio + "&rapidapi-key=784f1eda9amshe378e0999e4c745p1e2442jsn654e70901ac2")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        //request.setValue(token, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request){ (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                return
            }
            if response.statusCode == 200 {
                do {
                    if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [Dictionary<String,AnyObject>]
                    {
                        let status = json[0]["status"] as? Int;
                        
                        if status == nil {
                            let decoder = JSONDecoder()
                            let dataModel = try decoder.decode(ItemAirport.self, from: data)
                            print(dataModel)
                        }
                    }
                    
                } catch let error {
                    print("ha ocurrido un error: \(error.localizedDescription)")
                }
            } else {
                print("Estatus del request: \(response.statusCode)")
            }
        }.resume()
        
        let check = ItemAirport()
        return check
    }
}
