//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationImageTag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
