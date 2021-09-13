//
//  WeatherDetailVC.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var lblCity : UILabel!
    @IBOutlet weak var lblWeatherType : UILabel!
    @IBOutlet weak var lblTemp : UILabel!
    @IBOutlet weak var lblLat : UILabel!
    
    @IBOutlet weak var imgWeather : UIImageView!
    @IBOutlet weak var collWeather : UICollectionView!
    @IBOutlet weak var lblHumadity : UILabel!
    @IBOutlet weak var lblWindSpeed : UILabel!
    
    var entLocation = clsCityEntity()
    
    var entWeather = clsWeatherEntity()
    var arrWeather = [clsWeatherEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "City screen"
        self.getWeatherDetails()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnGetFiveDayWeatherForcast(sender:UIButton)
    {
        WeatherDetailVM().getWeatherDetailList(ent: entLocation)
        { (response,isSuccess,errorMessage) in
            
            DispatchQueue.main.async {
            if isSuccess
            {
                print(response)
                self.arrWeather = response
                if self.arrWeather.count > 0
                {
                    self.entWeather = self.arrWeather.first!
                    self.UpdateWeatherData()
                }
                self.collWeather.reloadData()
            }
            else
            {
                VGUtility.shared.showAlertWith(Title:"", Message:errorMessage,onVC:self)
                print(errorMessage)
            }
            }
        }
    }
    func UpdateWeatherData()
    {
        let dTemp = self.entWeather.main.temp
        let strTemp = String(format: "%.2f", dTemp)
        self.lblTemp.text = "\(strTemp)° C"
        self.lblCity.text = "\(self.entLocation.strLocality) , \(self.entLocation.strCity)"
        self.lblHumadity.text = "Humidity : \(self.entWeather.main.humidity)"
        self.lblWindSpeed.text = "Wind Speed \(entWeather.wind.speed)"
        if self.entWeather.arrWeather.count > 0
        {
            self.lblWeatherType.text = self.entWeather.arrWeather[0].main
            self.imgWeather.loadImageUsingCache(withUrl: "http://openweathermap.org/img/wn/\(self.entWeather.arrWeather[0].icon)@2x.png")
        }
        self.collWeather.reloadData()
        let strLat = Decimal(string: self.entLocation.strLat)?.TwoDigitNumber
        let strLong = Decimal(string: self.entLocation.strLat)?.TwoDigitNumber
        
        self.lblLat.text = "Lat: \(strLat ?? ""), Long : \(strLong ?? "")"
    }
    func getWeatherDetails()
    {
        WeatherDetailVM().getWeatherDetail(ent:self.entLocation)
        { (response,isSuccess,errorMessage) in
            
            DispatchQueue.main.async {
            if isSuccess
            {
                print(response)
                self.entWeather = response
                self.entWeather.main.temp = self.entWeather.main.temp - 273.15
                self.UpdateWeatherData()
                self.arrWeather.append(self.entWeather)
                self.collWeather.reloadData()
                self.UpdateWeatherData()
            }
            else
            {
                VGUtility.shared.showAlertWith(Title:"", Message:errorMessage,onVC:self)
                print(errorMessage)
            }
            }
        }
    }
}

extension WeatherDetailVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrWeather.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! clsWeatherCollCell
        let ent = self.arrWeather[indexPath.row]
        cell.lblTitle.text = ent.arrWeather.first?.main
        cell.lblSubTitle.text = ent.arrWeather.first?.description

        let date = NSDate(timeIntervalSince1970: TimeInterval(ent.dt) )
        print(date)
        
        cell.lblDate.text = VGUtility.shared.dateToString(date:date as Date,strFormat:"dd/MM/yyyy")
        cell.lblTime.text = VGUtility.shared.dateToString(date:date as Date,strFormat:"HH:mm")
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                return CGSize(width: (self.view.frame.width / 2 ) + 10, height:150)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collWeather.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.entWeather = arrWeather[indexPath.row]
        self.UpdateWeatherData()
    }
}

class clsWeatherCollCell: UICollectionViewCell
{
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var viwBG: UIView!
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
