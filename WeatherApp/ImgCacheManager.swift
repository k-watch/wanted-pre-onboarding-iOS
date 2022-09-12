//
//  ImgCacheManager.swift
//  WeatherApp
//
//  Created by 권용현 on 2022/09/12.
//

import Foundation
import UIKit

class ImgCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
