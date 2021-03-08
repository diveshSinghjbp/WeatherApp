//
//  AddLocationViewController.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/6/21.
//

import UIKit
import GoogleMaps

protocol AddCityDelegate {
    func userEnteredANewCityName(city: String)
    func userEnteredNewLatLon(latitute : Double, longitude : Double)
}

class AddLocationViewController: UIViewController,GMSMapViewDelegate {
    
    var delegate : AddCityDelegate?
    @IBOutlet var mapVieww: GMSMapView!
    var locationStr = String()

    var coordinate: CLLocationCoordinate2D?
    @IBOutlet weak var changeCityTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapVieww.delegate = self
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let lat = coordinate.latitude
        let long = coordinate.longitude

         print("Latitude: \(lat), Longitude: \(long)")
        
        createGMSMap(lat: lat, long: long, title: "Tapped Location", snippet: "Lat: \(lat), Long: \(long)")
        
        locationStr = "Latitude: \(lat), Longitude: \(long)"
        self.coordinate = coordinate

     }
    
    @objc private func createGMSMap(lat : Double, long: Double, title: String, snippet: String){

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
      //  marker.position = camera.target
        marker.title = title as String
        marker.snippet = snippet as String
        marker.map = mapVieww
        
    }

    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
      //  let cityName = changeCityTextField.text!
      //  delegate?.userEnteredANewCityName(city: cityName)
        
        print("locationStr--\(locationStr)")
        guard  let cordinate = self.coordinate else {
            print("Please tap on Map")
            return
        }
        delegate?.userEnteredNewLatLon(latitute: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0)
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: nil)
        
    }

}
