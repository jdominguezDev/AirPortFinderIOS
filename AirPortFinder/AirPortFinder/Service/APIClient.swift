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
}
