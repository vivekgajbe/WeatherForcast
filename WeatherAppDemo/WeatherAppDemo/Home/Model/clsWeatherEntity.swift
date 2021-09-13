//
//  clsWeatherEntity.swift
//  WeatherAppDemo
//
//  Created by vivek G on 10/09/21.
//

import UIKit


// MARK: - clsWeatherEntity
class clsWeatherEntity: Decodable {
    var coord = clsCoord()
    var arrWeather = [clsWeather]()
    var base: String
    var main = clsMain()
    var visibility: Int
    var wind = clsWind()
    var rain = clsRain()
    var clouds = clsClouds()
    var dt: Int
    var sys = clsSys()
    var timezone, id: Int
    var name: String
    var cod: Int
    
    init() {
        base = ""
        name = ""
        visibility = 0
        dt = 0
        timezone = 0
        id = 0
        cod = 0
        
    }
    
    init(json:[String:Any])
    {
        if let entcoord = json["coord"] as? [String:Any]
        {
            coord = clsCoord(json:entcoord)
        }
        if let weather = json["weather"] as? [[String:Any]]
        {
            for item in weather
            {
                let ent = clsWeather(json:item)
                print(ent)
                arrWeather.append(ent)
            }
        }
        if let entsys = json["sys"] as? [String:Any] //?? ["":""]
        {
            sys = clsSys(json:entsys)
        }
        if let entmain = json["main"] as? [String:Any] //?? ["":""]
        {
            main = clsMain(json:entmain)
        }
        if let entwind = json["wind"] as? [String:Any] //?? ["":""]
        {
            wind = clsWind(json:entwind)
        }
        if let entclouds = json["clouds"] as? [String:Any] //?? ["":""]
        {
            clouds = clsClouds(json:entclouds)
        }
        base = json["base"] as? String ?? ""
        visibility = json["visibility"] as? Int ?? 0
        dt = json["dt"] as? Int ?? 0
        timezone = json["timezone"] as? Int ?? 0
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        cod = json["cod"] as? Int ?? 0
    }
}

// MARK: - Clouds
class  clsClouds: Decodable {
    var all: Int
    init() {
        all = 0
    }
    init(json:[String:Any])
    {
        all = json["all"] as? Int ?? -1
    }
}

// MARK: - Coord
class clsCoord: Decodable {
    var lon, lat: Double
    init() {
        lon = 0.0
        lat = 0.0
    }
    init(json:[String:Any])
    {
        lon = json["lon"] as? Double ?? 0.0
        lat = json["lat"] as? Double ?? 0.0
    }
}
//
// MARK: - Main
class clsMain: Decodable {
    var temp, feels_like, temp_min, temp_max: Double
    var pressure, humidity,sea_level,grnd_level: Int
    init() {
        temp = 0.0
        feels_like = 0.0
        temp_min = 0.0
        temp_max = 0.0
        pressure = 0
        humidity = 0
        sea_level = 0
        grnd_level = 0
    }
    init(json:[String:Any]) {

        temp = json["temp"] as? Double ?? 0.0
        feels_like = json["feels_like"] as? Double ?? 0.0
        temp_min = json["temp_min"] as? Double ?? 0.0
        temp_max = json["temp_max"] as? Double ?? 0.0
        pressure = json["pressure"] as? Int ?? 0
        humidity = json["humidity"] as? Int ?? 0
        sea_level = json["sea_level"] as? Int ?? 0
        grnd_level = json["grnd_level"] as? Int ?? 0
    }
}

// MARK: - Rain
class clsRain: Decodable {
    var the1H: Double
    init() {
        the1H = 0.0
    }
    init(json:[String:Any]) {
        the1H = json["the1H"] as? Double ?? 0.0
    }
}
//
// MARK: - Sys
class clsSys: Decodable {
    var type, id: Int
    var country: String
    var sunrise, sunset: Int
    init() {
        type = 0
        id = 0
        country = ""
        sunrise = 0
        sunset = 0
    }
    init(json:[String:Any]) {
        id = json["id"] as? Int ?? 0
        type = json["type"] as? Int ?? 0
        country = json["country"] as? String ?? ""
        sunrise = json["sunset"] as? Int ?? 0
        sunset = json["sunset"] as? Int ?? 0
    }
}

// MARK: - Weather
class clsWeather: Decodable {
    var id: Int
    var main, description, icon: String

    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
    init(json:[String:Any])
    {
        id = json["id"] as? Int ?? 0
        main = json["main"] as? String ?? ""
        description = json["description"] as? String ?? ""
        icon = json["icon"] as? String ?? ""
    }
}

//// MARK: - Wind
class clsWind: Decodable {
    var speed: Double
    var deg: Int
    var gust: Double
    init() {
        speed = 0.0
        deg = 0
        gust = 0.0
    }
    init(json:[String:Any])
    {
        speed = json["speed"] as? Double ?? 0.0
        deg = json["deg"] as? Int ?? 0
        gust = json["gust"] as? Double ?? 0.0
    }
}
