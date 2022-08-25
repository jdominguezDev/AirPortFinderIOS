//
//  ItemAirportElement.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 25/08/22.
//

import Foundation

struct ItemAirportElement: Codable {
    var iataCode, icaoCode, name, alpha2CountryCode: String
    var latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case iataCode, icaoCode, name
        case alpha2CountryCode = "alpha2countryCode"
        case latitude, longitude
    }
}
