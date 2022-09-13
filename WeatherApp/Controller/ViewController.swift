//
//  ViewController.swift
//  WeatherApp
//
//  Created by 권용현 on 2022/09/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier: String = "countryCell"
    var selectIndex: Int = 0
    var weathers: [WeatherModel] = []
    let loading = LoadingViewController()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if self.weathers.count == 0 {return UITableViewCell()}
        
        let weather: WeatherModel = self.weathers[indexPath.row]
        
        cell.name.text = weather.name
        cell.celius.text = weather.main.celsius + "도"
        cell.humidity.text = String(weather.main.humidity) + "%"
        
        let cacheKey = NSString(string: weather.weather[0].iconImg)
        
        // 이미지 캐시 저장
        if let cachedImg = ImgCacheManager.shared.object(forKey: cacheKey) {
            cell.imgView.image = cachedImg
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        } else {
            DispatchQueue.global().async {
                guard let imageURL: URL = URL(string: weather.weather[0].iconImg) else { return }
                guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                
                DispatchQueue.main.async {
                    if let index: IndexPath = tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            if let image: UIImage = UIImage(data: imageData) {
                                
                                ImgCacheManager.shared.setObject(image, forKey: cacheKey)
                                cell.imgView.image = image
                                cell.setNeedsLayout()
                                cell.layoutIfNeeded()
                                
                            }
                        }
                    }
                }
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loading.modalPresentationStyle = .overCurrentContext
        self.loading.modalTransitionStyle = .crossDissolve
        
        // 데이터 요청 전 로딩뷰 생성
        present(self.loading, animated: true, completion: nil)
        reqWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecvWeathersNoti(_:)), name: DidRecvWeathersNoti, object: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let nextViewController: InfoViewController = segue.destination as? InfoViewController else { return }
        
        guard let row: Int = self.tableView.indexPathForSelectedRow?.row as? Int else { return }
        nextViewController.selectIndex = row
    }

    @objc func didRecvWeathersNoti(_ noti: Notification) {
        guard let weathers: [WeatherModel] = noti.userInfo?["weathers"] as? [WeatherModel] else { return }
        
        self.weathers = weathers
        
        // 데이터 요청 완료 후 로딩뷰 해제
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loading.dismiss(animated: true)
        }
    }
}



