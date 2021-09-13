//
//  VGConstants.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit

class VGConstants: NSObject {
    static let shared = VGConstants()

    private override init() {
        
    }
     
    static let APP_DEL : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @available(iOS 10.0, *)
    static let context = APP_DEL.persistentContainer.viewContext
    
    //Storyboard
    let sbHome = "Home"
    let sbVGWebView = "VGWebView"
    
    let VGWebViewController = "VGWebViewController"
    let HomeVC = "HomeVC"
    let WeatherDetailsVC = "WeatherDetailsVC"
    let AddLocationVC = "AddLocationVC"
    let SettingVC = "SettingVC"
    
    //core data keys
   static let WeatherDB = "WeatherDB"
    //entity name
   static let BookmarkCity = "BookmarkCity"
   
    
    ///Key for Driver Entity
    let cityName = "cityName"
    let lat = "lat"
    let long = "long"
    let postalCode = "postalCode"
    let country = "country"
    let locality = "locality"
    
    let strHelpScreenInfo = """
This is Weather app ,</br> You can view</br>- Todays weather forcast or </br>- 5 days hourly forcast. </br></br>
you can bookmark your favourite city and view weather report as needed.  </br></br>

<H2 style='font-size:50px'>Developer level Description:</H2> </br></br>
<p style='font-size:40px'>
Screen Name : Home</br></br>
-Used UITableView for displaying City list(via. CoreData)</br>
-User can delete city in (core data) entry list</br>
-User can search city records </br></br>

Screen Name :Weather details:</br></br>
-Used Collection view to display weather forcast list</br>
-As mentioned display forcast details like temperature, humidity, weather status and wind information </br>
-Also Provide button for 5 days weather forcast (this will display waether details as per list,User can click on each item to see details)</br></br>

Screen Name : Add Location : </br></br>
-Its a map screen  </br>
-User can click on map to change new location</br>
-Provide add button : to save location in Core data</br></br>

Screen Name : Help :</br></br>
- Display HTML text content on the screen</br></br></br>

Test cases File Name: CheckDecimalTests</br>
-This file helps to identify two digit decimal number/br>
-added number of test entries to check each function test cases/br>/br>

</p>

"""
}
