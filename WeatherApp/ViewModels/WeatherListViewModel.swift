//
//  WeatheListViewModel.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/7/21.
//

import Foundation
class WeatherListViewModel : WeatherRepositoryProtocol{
    func create(weatherModel: WeatherModel) {
        self.repository?.create(weatherModel: weatherModel)
        self.delegate?.fetchSuccess()
    }
    
    func gellAll() -> [WeatherModel]? {
        return self.repository?.gellAll()
    }
    
    func getById(id: Int) -> WeatherModel? {
        return self.repository?.getById(id: id)
    }
    
    func update(by id: Int, weatherModel: WeatherModel) -> Bool {
        guard let rep = repository else {
            return false
        }
        let res = rep.update(by: id, weatherModel: weatherModel)
        if(res == true) {
            delegate?.fetchSuccess()
        }
        else {
            delegate?.fetchError()
        }
        return res
    }
    
    func delete(for id: Int) -> Bool {
        guard let rep = repository else {
            return false
        }
        let res = rep.delete(for: id)
//        if(res == true) {
//            delegate?.fetchSuccess()
//        }
//        else {
//            delegate?.fetchError()
//        }
        return res
    }
    
    weak var delegate : LocationServiceProtocol? = nil
    var repository : WeatherRepositoryProtocol? = nil
    init(delegate : LocationServiceProtocol, repository : WeatherRepositoryProtocol) {
        self.delegate = delegate
        self.repository = repository

    }
    
    
  
}
