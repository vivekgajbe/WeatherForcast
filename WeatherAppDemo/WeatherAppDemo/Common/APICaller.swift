//
//  APICaller.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import Foundation

class APICaller
{
    static let shared = APICaller()
    let apologiesMessage = "We apologize this service is temporarily unavailable.Please try later."
    
    enum MyError:Error {
        case failedToFetch
        case NODataFound
    }

    func ParseDataInDict(data :Data?) -> ([String:Any],Bool)
    {
        guard let data = data else {
            return (["":""],false) }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? Any else {
                return (["":""],false)
            }

            if let code = json as? Array<Any> //Check for the array
            {
                let dictata : [String: Any] = ["data" : code]
                return (dictata,true)
            }
            else if let jsonData = json as? [String:Any] //Check for the code tag
            {
                return (jsonData,true)
            }
            else
            {
                return (["":""],false)
            }
            
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)//No Value in JSON
            return (["":""],false)
        }
    }
    func  fetch(with url : String,completion:@escaping (Result<[String:Any],MyError>) -> Void)
    {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.failedToFetch))
                return
            }
            if error == nil
            {
                let isSuccess = self.ParseDataInDict(data: data).1
                
                if isSuccess == true
                {
                    let dictData = self.ParseDataInDict(data: data).0
                    completion(.success(dictData))
                }
                else
                {
                    completion(.failure(.failedToFetch))
                }
            }
            else
            {
                completion(.failure(.failedToFetch))
            }
        }
        task.resume()
    }
}
