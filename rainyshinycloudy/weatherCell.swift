//
//  weatherCell.swift
//  rainyshinycloudy
//
//  Created by AIR on 15.11.2018.
//  Copyright © 2018 AIR. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = "\(forecast.weatherType)"
        weatherIcon.image = UIImage(named:forecast.weatherType)
        dayLabel.text = forecast.date
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
