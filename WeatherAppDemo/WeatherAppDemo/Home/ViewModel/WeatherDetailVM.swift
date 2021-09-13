//
//  WeatherDetailVM.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit

class WeatherDetailVM: NSObject {
    
    func getWeatherDetailList(ent:clsCityEntity, completion:@escaping (_ response: [clsWeatherEntity],_ completed:Bool,_ errorMessage : String)->Void)
    {
        
        APICaller.shared.fetch(with: "http://api.openweathermap.org/data/2.5/forecast?lat=\(ent.strLat)&lon=\(ent.strLong)&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric" ) { (result) in
            
                
            switch result
            {
            case .success(let data):
                
                    var arr = [clsWeatherEntity]()
                    print(data)
                    if let list = data["list"] as? [[String:Any]]
                    {
                        for item in list
                        {
                            let ent = clsWeatherEntity(json:item )
                            arr.append(ent)
                        }
                    }
                    
                    completion(arr,true,"")
                
                break
            case .failure(let error):
                completion([],false,error.localizedDescription)
                break
            }
            
        }
    }
    func getWeatherDetail(ent:clsCityEntity,completion:@escaping (_ response: clsWeatherEntity,_ completed:Bool,_ errorMessage : String)->Void)
    {
        APICaller.shared.fetch(with: "http://api.openweathermap.org/data/2.5/weather?lat=\(ent.strLat)&lon=\(ent.strLong)&appid=fae7190d7e6433ec3a45285ffcf55c86" ) { (result) in
            
                
            switch result
            {
            case .success(let data):
                
                    print(data)
                    let ent = clsWeatherEntity(json:data )
                    completion(ent,true,"")
                break
            case .failure(let error):
                completion(clsWeatherEntity(),false,error.localizedDescription)
                break
            }
            
        }
    }
}
