//
//  ViewController.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/27/21.
//

import UIKit
import SwiftUI

let weatherCellIdentifier = "WeatherCellIdentifier"

protocol WeatherFetchDelegation {
    func didRecieveDataForInitialRequest()
    func didRecieveDataForSubsequentRequest()
    func didRecievedImageResponse()
}
enum FetchingState {
    case fetchInitial
    case fetchDetatils
    case fetchImages
}
extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
}
class WeatherViewController: UIViewController {
    var fetchingState : FetchingState = .fetchInitial
    
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "fae7190d7e6433ec3a45285ffcf55c86"
    
    
    @IBOutlet weak var locationListTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    
    
    var weatherListViewModel : WeatherListViewModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherListViewModel = WeatherListViewModel(delegate: self, repository: WeatherRepositoryData())
        if(weatherListViewModel?.gellAll()?.count == 0) {
            emptyView.isHidden = false
            locationListTableView.isHidden = true
        }
        else {
            emptyView.isHidden = true
            locationListTableView.isHidden = false
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : AddLocationViewController = segue.destination as! AddLocationViewController
        destVC.delegate = self
    }
    
}

extension WeatherViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel?.gellAll()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableviewCell = tableView.dequeueReusableCell(withIdentifier: weatherCellIdentifier, for: indexPath) as! WeatherTableViewCell
        tableviewCell.locationName?.text = weatherListViewModel?.gellAll()?[indexPath.row].city
        tableviewCell.locationImageTag?.image = UIImage(named: weatherListViewModel?.gellAll()?[indexPath.row].weatherIconName ?? "")
        
        return tableviewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destination.weatherModel = weatherListViewModel?.gellAll()?[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard var objects = weatherListViewModel?.gellAll() else{
                return
            }
            let id = objects[indexPath.row].id
            weatherListViewModel?.delete(for: id)
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}

extension WeatherViewController : LocationServiceProtocol {
    func fetchSuccess() {
        //hide activity indicator and reload table view
        if(weatherListViewModel?.gellAll()?.count == 0) {
            emptyView.isHidden = false
            locationListTableView.isHidden = true
        }
        else {
            emptyView.isHidden = true
            locationListTableView.isHidden = false
            self.locationListTableView.reloadData()
        }
        
    }
    
    func fetchError() {
        // show alert view
        
    }
}

extension WeatherViewController : AddCityDelegate{
    func userEnteredNewLatLon(latitute: Double, longitude: Double) {
        WeatherService(networkSession: URLSession.shared).getWeatherData(urlStr: WEATHER_URL, latitute: latitute, longitude: longitude, APIKey: APP_ID) {[weak self] (result) in
            switch result {
            case .failure(let error) :
                print(error.localizedDescription)
            case .success(let model) :
                print(model.city)
                self?.weatherListViewModel?.create(weatherModel: model)
            }
        }
    }
    
    func userEnteredANewCityName(city: String) {
        print("city name \(city)")
        WeatherService(networkSession: URLSession.shared).getWeatherData(urlStr: WEATHER_URL, cityName: city, APIKey: APP_ID) {[weak self] (result) in
            switch result {
            case .failure(let error) :
                print(error.localizedDescription)
            case .success(let model) :
                print(model.city)
                self?.weatherListViewModel?.create(weatherModel: model)
                
            }
        }
        
    }
}

