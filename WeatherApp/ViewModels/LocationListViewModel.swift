//
//  LocationListViewModel.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation
protocol FetchService {
    func updateLocationData(delegate : LocationServiceProtocol)
}
class LocationListViewModel : FetchService {
    let locationService : FileReaderService = FileReaderService()
    var locations : [LocationModel] = [LocationModel]()
    weak var delegate : LocationServiceProtocol? = nil
    func updateLocationData(delegate : LocationServiceProtocol) {
       
        do {
            try locationService.readJsonFile(fileName: "cities", withExtension: "json", ofType: [LocationModel].self, onResultQueue: .main) { (result) in
                switch(result) {
                case .success(let locations) :
                    self.locations = locations
                    delegate.fetchSuccess()
                break
                case .failure(let error) :
                    print(error.localizedDescription)
                    delegate.fetchError()
                }
            }
            
        }
        catch FileError.emptyFile {
            delegate.fetchError()
        }
        catch FileError.invalidPath {
            delegate.fetchError()
        }
        catch  {
            delegate.fetchError()
        }
        
        
    }
}
