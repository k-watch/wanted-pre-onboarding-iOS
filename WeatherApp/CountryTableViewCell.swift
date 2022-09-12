//
//  CountryTableViewCell.swift
//  WeatherApp
//
//  Created by 권용현 on 2022/09/12.
//

import UIKit
class CountryTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var celius: UILabel!
    @IBOutlet var humidity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
