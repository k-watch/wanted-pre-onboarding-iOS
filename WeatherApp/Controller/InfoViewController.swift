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
    @IBOutlet var desc: UILabel!
    @IBOutlet var celsius: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var speed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let weather: WeatherModel = weathers[selectIndex]
        
        let cacheKey = NSString(string: weather.weather[0].iconImg)
        
        if let cachedImg = ImgCacheManager.shared.object(forKey: cacheKey) {
            self.weatherImg.image = cachedImg
        } else {
            DispatchQueue.global().async {
                guard let imageURL: URL = URL(string: weather.weather[0].iconImg) else { return }
                guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                
                DispatchQueue.main.async {
                    
                    if let image: UIImage = UIImage(data: imageData) {
                        
                        ImgCacheManager.shared.setObject(image, forKey: cacheKey)
                        self.weatherImg.image = image
                    }
                }
            }
        }
        
        self.name.text = weather.name
        self.desc.text = weather.weather[0].description
        self.celsius.text = weather.main.fullCelsius
        self.humidity.text = "\(String(weather.main.humidity))%"
        self.pressure.text = "\(String(weather.main.pressure))hPa"
        self.speed.text = "\(String(weather.wind.speed))m/s"
    }
}
