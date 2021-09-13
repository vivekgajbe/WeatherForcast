//
//  VGUtility.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import Foundation
import UIKit

class VGUtility
{
    static var shared = VGUtility()

    private init()
    {}

    //MARK: - show alert on the screen
    func showAlertWith(Title:String, Message:String,onVC:UIViewController){
        let alertMessage = UIAlertController.init(title: Title, message: Message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            //println("you have pressed OK button");
        }
        alertMessage.addAction(OKAction)
        onVC.present(alertMessage, animated: true, completion: nil)
        //
    }
    
    //Date formating method
    func dateToString(date:Date,strFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat//"dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    func stringToDate(strDate:String,strFormat:String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat//"dd-MM-yyyy HH:mm:ss"
        let date = dateFormatter.date(from: strDate) //date string
        print(date ?? "") //Convert String to Date
        return date!
    }
}
//MARK:- This extension is for loading and caching images
//let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String,WithBackgroundImageNamed:String = "NoImage")
    {
        let url = URL(string: urlString)

//        self.sd_setImage(with: url, placeholderImage: UIImage(named: WithBackgroundImageNamed))
        self.image = nil
        if WithBackgroundImageNamed != "" && urlString == ""
        {
            self.image = UIImage(named: WithBackgroundImageNamed)
            self.contentMode = .scaleAspectFit
        }
        if self.image != nil
        {
            self.image = nil
        }

//        // check cached image
////        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
////            self.image = cachedImage
////            return
////        }
        if url == nil
        {
            self.image = UIImage(named: WithBackgroundImageNamed)
            return
        }
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

        DispatchQueue.main.async {
        //indicator.center = self.center
        let frame = CGRect(x: (self.frame.size.width / 2) - 15 , y: (self.frame.size.height / 2) - 15, width: 30, height: 30)
        indicator.frame = frame
        //indicator.center = self.center
        self.addSubview(indicator)
            self.bringSubviewToFront(indicator)
        indicator.startAnimating()
        // if not, download image from url

            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil //server side error
                    {
                        print(error!)
                        indicator.stopAnimating()
                        return
                    }
                    if let image = UIImage(data: data!) //data return from URL session
                    {
                        //imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                        indicator.stopAnimating()
                    }
                    else //If not a valid image then set default image
                    {
                        self.image = UIImage(named: WithBackgroundImageNamed)
                        indicator.stopAnimating()
                    }
                }
            }).resume()
        }
    }
}


