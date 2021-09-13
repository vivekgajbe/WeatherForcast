//
//  VGButton.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit


@IBDesignable
class VGButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return UIColor.lightGray
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
           set {
               layer.shadowRadius = newValue
           }
           get{
               return layer.shadowRadius
           }
       }
    @IBInspectable var shadowColors : UIColor{
           get{
               return UIColor.init(cgColor: layer.shadowColor!)
           }
           set {
               layer.shadowColor = newValue.cgColor
           }
       }

}
