### 📙 원티드 프리온보딩 프론트엔드 코스 사전과제

OpenWeatherMap API를 이용해 날씨 정보를 알려주는 APP입니다.

---
### **사용 기술**
- IOS (Swift | UIKit)

---
### **첫 번째 화면**
![image](https://user-images.githubusercontent.com/30553624/189872448-bf6fbeed-555c-4695-8fb3-138f54c0cc87.png)
- tableView 를 이용하여 각 도시별 이름, 날씨 아이콘, 현재기온, 현재습도를 보여줍니다.
- URLSessionDataTask 를 이용하여 API 통신을 통해 데이터를 다운받습니다. 다운이 완료되면 ViewController 에 Notification 을 발송합니다.  
- NSCache 를 이용하여 이미지 캐시를 활용했습니다.

---
### **두 번째 화면**
![image](https://user-images.githubusercontent.com/30553624/189872530-dbd9ea58-404b-4c3c-a6bf-c39e8362622b.png)
- 날씨 아이콘, 도시 이름, 날씨 설명, 현재기온(최저기온/최고기온)(체감기온), 습도, 기압, 풍속을 보여줍니다.
