//
//  Request.swift
//  WeatherApp
//
//  Created by 권용현 on 2022/09/12.
//

import Foundation

var  cities: [String: String] = ["Gongju": "공주", "Gwangju": "광주", "Gumi": "구미", "Gunsan": "군산", "Daegu": "대구", "Daejeon": "대전", "Mokpo": "목포", "Busan": "부산", "Seosan City": "서산", "Seoul": "서울", "Sokcho": "속초", "Suwon-si": "수원", "Suncheon": "순천", "Ulsan": "울산", "Iksan": "익산", "Jeonju": "전주", "Jeju City": "제주", "Cheonan": "천안", "Cheongju-si": "청주", "Chuncheon": "춘천"]
var reqCities: [String] = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju", "Chuncheon"]
var weathers: [WeatherMain] = []
let DidRecvWeathersNoti: Notification.Name = Notification.Name("DidRecvWeathers")

func reqWeather() {
    for city in reqCities {
        guard let url: URL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + Storage().apiKey + "&lang=kr") else {return}
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                var apiRes = try JSONDecoder().decode(WeatherMain.self, from: data)
                apiRes.name = cities[apiRes.name]!
                weathers.append(apiRes)
                
                if weathers.count == cities.count {
                    weathers = weathers.sorted(by: {$0.name < $1.name})
                    NotificationCenter.default.post(name: DidRecvWeathersNoti, object: nil, userInfo: ["weathers": weathers])
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
                                                        
