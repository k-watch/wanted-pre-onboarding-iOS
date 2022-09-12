//
//  Model.swift
//  WeatherApp
//
//  Created by 권용현 on 2022/09/12.
//

import Foundation

// 도시이름, 날씨 아이콘, 현재기온, 현재습도
// 체감기온, 현재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명

struct Weather: Codable {
    let id: Int
    let icon: String
    let description: String
    
    var iconImg: String {
        return "https://openweathermap.org/img/wn/" + self.icon + "@2x.png"
    }
}

struct Main: Codable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let humidity: Int
    
    func calTemp(temp: Float) -> String {
        return String(format: "%.2f", temp - 273.15)
    }
    
    var celsius: String {
        return calTemp(temp: self.temp)
    }
    var fellsCelsius: String {
        return calTemp(temp: self.feelsLike)
    }
    var celsiusMin: String {
        return calTemp(temp: self.tempMin)
    }
    var celsiusMax: String {
        return calTemp(temp: self.tempMax)
    }
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity, pressure
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Float
}

struct WeatherMain: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    var name: String
}
