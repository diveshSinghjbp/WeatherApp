//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/7/21.
//

import Foundation
import CoreData
protocol WeatherRepositoryProtocol {
    func create(weatherModel : WeatherModel)
    func gellAll() -> [WeatherModel]?
    func getById(id : Int) -> WeatherModel?
    func update(by id: Int , weatherModel : WeatherModel) -> Bool
    func delete(for id : Int)->Bool
    
}

struct WeatherRepositoryData : WeatherRepositoryProtocol {
    func create(weatherModel: WeatherModel) {
        let cdWeatherModel = CDWeatherModel(context: PersistanceStorage.shared.context)
        updateCDModel(cdWeatherModel: cdWeatherModel, with: weatherModel)
        PersistanceStorage.shared.saveContext()
    }
    
    func gellAll() -> [WeatherModel]? {

        let result = PersistanceStorage.shared.getManagedObject(ofType: CDWeatherModel.self)
        
        var weathers : [WeatherModel] = [WeatherModel]()
        result?.forEach({ (cdWeatherModel) in
            let weatherModel = cdWeatherModel.convertToWeatherModel()
            weathers.append(weatherModel)
        })
        return weathers
    }
    
    func getById(id: Int) -> WeatherModel? {
        let result = getCDWeatherModel(forId: id)
        return result?.convertToWeatherModel()
    }
    
    func update(by id: Int, weatherModel: WeatherModel) -> Bool {
        guard let cdWeatherModel = getCDWeatherModel(forId: id) else {
            return false
        }
        updateCDModel(cdWeatherModel: cdWeatherModel, with: weatherModel)
        PersistanceStorage.shared.saveContext()
        return true
    }
    
    func delete(for id: Int) -> Bool {
        guard let cdWeatherModel = getCDWeatherModel(forId: id) else {
            return false
        }
        PersistanceStorage.shared.context.delete(cdWeatherModel)
        PersistanceStorage.shared.saveContext()
        return true
    }
    private func getCDWeatherModel(forId id: Int) -> CDWeatherModel? {
        let fetchRequest = NSFetchRequest<CDWeatherModel>(entityName: "CDWeatherModel")
        
        let predicate : NSPredicate = NSPredicate(format: "id == \(id)")
        fetchRequest.predicate = predicate
        do {
            let result = try PersistanceStorage.shared.context.fetch(fetchRequest)
            return result.first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    private func updateCDModel(cdWeatherModel: CDWeatherModel, with weatherModel : WeatherModel) {
        cdWeatherModel.temperature = Int64(weatherModel.temperature)
        cdWeatherModel.tempMax = Int64(weatherModel.tempMax)
        cdWeatherModel.tempMin = Int64(weatherModel.tempMin)
        cdWeatherModel.tempFeelsLike = Int64(weatherModel.tempFeelsLike)
        cdWeatherModel.condition = Int64(weatherModel.condition)
        cdWeatherModel.city = (weatherModel.city)
        cdWeatherModel.weatherDisc = (weatherModel.weatherDisc)
        cdWeatherModel.weatherIcon = (weatherModel.weatherIconName)
        cdWeatherModel.windSpeed = (weatherModel.windSpeed)
        cdWeatherModel.windDirection = Int64(weatherModel.windDirection)
        cdWeatherModel.latitude = (weatherModel.latitude)
        cdWeatherModel.longitude = (weatherModel.longitude)
        cdWeatherModel.id = Int64(weatherModel.id)
        cdWeatherModel.humidity = Int64(weatherModel.humidity)
    }
}
