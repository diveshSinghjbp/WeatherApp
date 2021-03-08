//
//  CDWeatherModel+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/7/21.
//
//

import Foundation
import CoreData


extension CDWeatherModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeatherModel> {
        return NSFetchRequest<CDWeatherModel>(entityName: "CDWeatherModel")
    }

    @NSManaged public var temperature: Int64
    @NSManaged public var tempMax: Int64
    @NSManaged public var tempMin: Int64
    @NSManaged public var tempFeelsLike: Int64
    @NSManaged public var condition: Int64
    @NSManaged public var city: String?
    @NSManaged public var weatherDisc: String?
    @NSManaged public var weatherIcon: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDirection: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var id: Int64
    @NSManaged public var humidity: Int64

}

extension CDWeatherModel : Identifiable {

}
extension CDWeatherModel {
    func convertToWeatherModel() ->WeatherModel {
        let weatherModel = WeatherModel(temperature: Int(self.temperature),
                                        tempMax: Int(self.tempMax),
                                        tempMin: Int(self.tempMin),
                                        tempFeelsLike: Int(self.tempFeelsLike),
                                        condition: Int(self.condition),
                                        city: self.city ?? "Delhi",
                                        weatherDisc: self.weatherDisc ?? "No data available",
                                        weatherIconName: self.weatherIcon ?? "INVALID",
                                        latitude: self.latitude,
                                        longitude: self.longitude,
                                        id: Int(self.id),
                                        windSpeed: self.windSpeed,
                                        windDirection: Int(self.windDirection),
                                        humidity: Int(self.humidity))
        return weatherModel
    }
}
