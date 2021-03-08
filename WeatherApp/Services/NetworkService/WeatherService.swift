//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/6/21.
//

import Foundation

class WeatherService {
    let networkManager : NetworkManager!
    init(networkSession : NetworkSession) {
        networkManager = NetworkManager(session: networkSession)
    }
    func getWeatherData(urlStr: String,
                        latitute: Double,
                        longitude : Double,
                        APIKey : String,
                        then completionHandler : @escaping (Result<WeatherModel, Error>)->Void){
                
        
        let queryItems = [URLQueryItem(name: "lat", value: String(latitute)),URLQueryItem(name: "lon", value: String(longitude)), URLQueryItem(name: "appid", value: APIKey)]
        var urlComps = URLComponents(string: urlStr)!
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else {
            completionHandler(.failure(APIError.invalidURL))
            return
        }
        networkManager.loadData(from: url) { (data, error) in
            if let _ = error {
                completionHandler(.failure(APIError.invalidData))
                return
            }
            guard let dataObj = data else{
                completionHandler(.failure(APIError.invalidData))
                return
            }
            let str = String(decoding: dataObj, as: UTF8.self)
            print(str)

            dataObj.decode(as: WeatherInfo.self, handleOn: .main) { (result) in
                switch result {
                case .failure(_) : completionHandler(.failure(APIError.jsonParsingFailure))
                case .success(let weatherInfo) : completionHandler(.success(WeatherModel(weatherInfo: weatherInfo)))
                    
                }
            }
        }
                
    }
    func getWeatherData(urlStr: String,
                        cityName: String,
                        APIKey : String,
                        then completionHandler : @escaping (Result<WeatherModel, Error>)->Void){
                
        
        let queryItems = [URLQueryItem(name: "q", value: cityName  ), URLQueryItem(name: "appid", value: APIKey)]
        var urlComps = URLComponents(string: urlStr)!
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else {
            completionHandler(.failure(APIError.invalidURL))
            return
        }
        networkManager.loadData(from: url) { (data, error) in
            if let _ = error {
                completionHandler(.failure(APIError.invalidData))
                return
            }
            guard let dataObj = data else{
                completionHandler(.failure(APIError.invalidData))
                return
            }
            let str = String(decoding: dataObj, as: UTF8.self)
            print(str)

            dataObj.decode(as: WeatherInfo.self, handleOn: .main) { (result) in
                switch result {
                case .failure(_) : completionHandler(.failure(APIError.jsonParsingFailure))
                case .success(let weatherInfo) : completionHandler(.success(WeatherModel(weatherInfo: weatherInfo)))
                    
                }
            }
        }
                
    }
}
