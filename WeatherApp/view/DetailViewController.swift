//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Divesh Singh on 3/1/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var rain: UILabel!
    @IBOutlet weak var windInformation: UILabel!
    var weatherModel : WeatherModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.temperature.text = String(weatherModel?.temperature ?? 0)
        self.humidity.text = String(weatherModel?.humidity ?? 0)
        self.windInformation.text = String(weatherModel?.windSpeed ?? 0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
