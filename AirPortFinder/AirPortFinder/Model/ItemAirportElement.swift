//
//  ItemAirportElement.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 25/08/22.
//

import Foundation

struct ItemAirportElement: Codable {
    let iataCode: String
    let icaoCode: String?
    let name: String
    let alpha2CountryCode: Alpha2CountryCode
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case iataCode, icaoCode, name
        case alpha2CountryCode = "alpha2countryCode"
        case latitude, longitude
    }
}

enum Alpha2CountryCode: String, Codable {
    case us = "US"
}
