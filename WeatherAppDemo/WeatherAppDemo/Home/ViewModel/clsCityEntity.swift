//
//  clsCityEntity.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit

class clsCityEntity: Decodable {
    var strCity = ""
    var strLat = ""
    var strLong = ""
    var strLocality = ""
    var strPostalCode = ""
    var strCountry = ""
    
    init() {
        strCity = ""
        strLat = ""
        strLong = ""
        strLocality = ""
        strPostalCode = ""
        strCountry = ""
    }
    init(json:[String:Any])
    {
        strCity = json["strCity"] as? String ?? ""
        strLat = json["strLat"] as? String ?? ""
        strLong = json["strLong"] as? String ?? ""
        strLocality = json["strLocality"] as? String ?? ""
        strPostalCode = json["strPostalCode"] as? String ?? ""
        strCountry = json["strCountry"] as? String ?? ""
        
    }
}
extension Decimal
{
//    func string(decimal:Decimal) -> String
        var TwoDigitNumber: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.roundingMode = .floor
        return formatter.string(from: self as NSDecimalNumber ) ?? ""
    }
    var celciousToFarenheit : String {
        
        let iResult = self * (9/5) + 32
        return Decimal(string: "\(iResult)")?.TwoDigitNumber ?? ""
    }
    var FarenheitToCelcious: String
    {
        let iResult = self - 32  * (5/9)
        return Decimal(string: "\(iResult)")?.TwoDigitNumber ?? ""
    }
}
