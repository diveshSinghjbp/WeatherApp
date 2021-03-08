//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/6/21.
//

import Foundation

struct WeatherInfo: Codable {
    let wind: Wind
    let main: Main
    let id: Int
    let clouds: Clouds
    let timezone, cod, visibility: Int
    let coord: Coord
    let dt: Int
    let base: String
    let weather: [Weather]
    let name: String
    let sys: Sys
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let tempMax: Double
    let pressure, humidity: Int
    let feelsLike, temp, tempMin: Double

    enum CodingKeys: String, CodingKey {
        case tempMax = "temp_max"
        case pressure, humidity
        case feelsLike = "feels_like"
        case temp
        case tempMin = "temp_min"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunset, sunrise: Int
    let country: String
}

// MARK: - Weather
struct Weather: Codable {
    let main, icon: String
    let id: Int
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main, icon, id
        case weatherDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let deg: Int
    let speed: Double
}



class WeatherModel {

    //Declare your model variables here
    var temperature         : Int
    var tempMax             : Int
    var tempMin             : Int
    var tempFeelsLike       : Int
    
    var condition           : Int
    var city                : String
    var weatherDisc         : String
    var weatherIconName     : String
    
    var latitude            : Double
    var longitude           : Double
    var id                  : Int
    var windSpeed           : Double
    var windDirection       : Int
    
    
    var humidity : Int
    
    init(temperature: Int,
         tempMax: Int,
         tempMin: Int,
         tempFeelsLike: Int,
         condition: Int,
         city: String,
         weatherDisc: String,
         weatherIconName: String,
         latitude: Double,
         longitude: Double,
         id: Int,
         windSpeed: Double,
         windDirection: Int,
         humidity: Int) {
        
        
        self.temperature                = temperature
        self.tempMax                    = tempMax
        self.tempMin                    = tempMin
        self.tempFeelsLike              = tempFeelsLike
        self.condition                  = condition
        self.city                       = city
        self.weatherDisc                = weatherDisc
        self.weatherIconName            = weatherIconName
        self.latitude                   = latitude
        self.longitude                  = longitude
        self.id                         = id
        self.windSpeed                  = windSpeed
        self.windDirection              = windDirection
        self.humidity                   = humidity
    
    }
    init(weatherInfo : WeatherInfo) {
        
        self.temperature = Int(weatherInfo.main.temp - 273.5)
        self.tempMax = Int(weatherInfo.main.tempMax - 273.5)
        self.tempMin = Int(weatherInfo.main.tempMin - 273.5)
        self.tempFeelsLike = Int(weatherInfo.main.feelsLike - 273.5)
        
        self.condition = weatherInfo.weather[0].id
        self.city = weatherInfo.name
        self.weatherDisc = weatherInfo.weather[0].weatherDescription
        
        self.windSpeed = weatherInfo.wind.speed
        self.windDirection = weatherInfo.wind.deg
        
        self.latitude = weatherInfo.coord.lat
        self.longitude = weatherInfo.coord.lon
        self.id = weatherInfo.id
        switch (condition) {
        
            case 0...300 :
                self.weatherIconName =  "thunderstorm"
            
            case 301...500 :
                self.weatherIconName = "rain"
            
            case 501...600 :
                self.weatherIconName = "snow"
            
            case 601...700 :
                self.weatherIconName = "snow"
            
            case 701...771 :
                self.weatherIconName = "fog"
            
            case 772...799 :
                self.weatherIconName = "windy"
            
            case 800 :
                self.weatherIconName = "sunny"
            
            case 801...804 :
                self.weatherIconName = "party-cloudy"
            
            case 900...903, 905...1000  :
                self.weatherIconName = "thunderstorm"
            
            case 903 :
                self.weatherIconName = "snow"
            
            case 904 :
                self.weatherIconName = "sunny"
            
            default :
                self.weatherIconName = "dunno"
            }

        self.humidity = weatherInfo.main.humidity
        
    }
    //This method turns a condition code into the name of the weather condition image
}
