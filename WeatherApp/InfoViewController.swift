//
//  InfoViewController.swift
//  WeatherApp
//
//  Created by 권용현 on 2022/09/12.
//

import UIKit

class InfoViewController: UIViewController {
    var selectIndex: Int = 0
      
      @IBOutlet var weatherImg: UIImageView!
      @IBOutlet var name: UILabel!
      @IBOutlet var celsius: UILabel!
      @IBOutlet var humidity: UILabel!
      @IBOutlet var desc: UILabel!
      
      override func viewDidLoad() {
          super.viewDidLoad()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          let weather: WeatherMain = weathers[selectIndex]
          
          let cacheKey = NSString(string: weather.weather[0].iconImg)
          
          if let cachedImg = ImgCacheManager.shared.object(forKey: cacheKey) {
              self.weatherImg.image = cachedImg
          }
              
          
          self.name.text = weather.name
          self.celsius.text = weather.main.celsius + "(" + weather.main.celsiusMin + "/" + weather.main.celsiusMax + ") [" + weather.main.fellsCelsius + "]"
          self.humidity.text = String(weather.main.humidity) + "/" + String(weather.main.pressure) + "/" + String(weather.wind.speed)
          self.desc.text = weather.weather[0].description
      }
}
