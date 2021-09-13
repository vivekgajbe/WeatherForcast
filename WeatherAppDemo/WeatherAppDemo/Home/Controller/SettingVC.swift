//
//  SettingVC.swift
//  WeatherAppDemo
//
//  Created by vivek G on 13/09/21.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var txtCelcious : UITextField!
    @IBOutlet weak var txtFarenhite : UITextField!
    
    @IBOutlet weak var lblCelConvResult : UILabel!
    @IBOutlet weak var lblFarConvResult : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Setting"
        // Do any additional setup after loading the view.
    }

    @IBAction func CelciousToFeranhite(sender:Any)
    {
        self.view.endEditing(true)
        let iFarenheit = Decimal(string: txtCelcious.text ?? "0.0")?.celciousToFarenheit
        self.lblCelConvResult.text = "Fahrenheit : \(iFarenheit ?? "0.0")"
    }
    @IBAction func FeranhiteToCelcious(sender:Any)
    {
        self.view.endEditing(true)
        let iCelcious = Decimal(string: txtFarenhite.text ?? "0.0")?.FarenheitToCelcious
        self.lblFarConvResult.text = "Celcious :\(iCelcious ?? "0.0") "
    }
}
