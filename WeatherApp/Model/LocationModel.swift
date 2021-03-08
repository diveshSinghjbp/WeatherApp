//
//  CityModel.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation

struct LocationModel: Codable {
    let city, growthFrom2000_To2013: String
    let latitude, longitude: Double
    let population, rank, state: String

    enum CodingKeys: String, CodingKey {
        case city
        case growthFrom2000_To2013 = "growth_from_2000_to_2013"
        case latitude, longitude, population, rank, state
    }
}

typealias Cities = [LocationModel]
