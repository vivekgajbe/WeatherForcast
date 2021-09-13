//
//  HomeVC.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tblBookmarkCity : UITableView!
    @IBOutlet weak var lblNoDataFound : UILabel!
    var arrCityList = [Any]()
    var arrCity = [clsCityEntity]()
    var arrSearchCity = [clsCityEntity]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNoDataFound.isHidden = true
        self.navigationItem.title = "Home"
        
        self.tblBookmarkCity.estimatedRowHeight = 60
        self.tblBookmarkCity.rowHeight = UITableView.automaticDimension
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getSavedData()
    }
    ///Get data saved for vehicle from local storage
    @objc func getSavedData(){
        coreDataStructure().getSavedData(entName: VGConstants.BookmarkCity) { (result, isSucces) in
            if isSucces{
                self.arrCity.removeAll()
                self.arrSearchCity.removeAll()
                
                self.arrCityList = result as! [Any]
                for item in self.arrCityList
                {
                    let ent = clsCityEntity()
                    ent.strCity = (item as AnyObject).cityName ?? ""
                    ent.strLat = (item as AnyObject).lat ?? "" //?? ""
                    ent.strLong = (item as AnyObject).long ?? ""
                    ent.strLocality = (item as AnyObject).locality ?? ""
                    ent.strPostalCode = (item as AnyObject).postalCode ?? ""
                    ent.strCountry = (item as AnyObject).country ?? ""//?? ""
                    
                    self.arrCity.append(ent)
                    self.arrSearchCity.append(ent)
                }
                
                self.lblNoDataFound.isHidden =  self.arrSearchCity.count == 0 ? false : true
                
                self.tblBookmarkCity.reloadData()
            }
        }
    }
    @IBAction func btnAddNewCity(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: VGConstants.shared.AddLocationVC) as! AddLocationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSetting(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: VGConstants.shared.SettingVC) as! SettingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnHelpClick(_ sender: Any) {
        let sb = UIStoryboard(name: VGConstants.shared.sbVGWebView, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VGConstants.shared.VGWebViewController) as! VGWebViewController
        
        vc.bisHTMLContent = true
        vc.urlToLoad = VGConstants.shared.strHelpScreenInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSearchCityClicked(_ sender: Any) {
        
    }
}

extension HomeVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchCity.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clsCitylistCell
        let ent = arrSearchCity[indexPath.row]
        
        cell.lblName.text = "Locality : \(ent.strLocality)\nCity : \(ent.strCity) \nCountry:\(ent.strCountry) \npostalCode:\(ent.strPostalCode)"
        cell.lblName.numberOfLines = 0
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(deleteRecord), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailVC") as! WeatherDetailVC
        vc.entLocation = self.arrSearchCity[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteRecord(sender:UIButton)
    {
        print("delete : \(sender.tag)")
        let ent = self.arrSearchCity[sender.tag]
        coreDataStructure().deleteReminderFor(strPostalCode: ent.strPostalCode) { (isSuccess) in
            if isSuccess
            {
                self.getSavedData()
                VGUtility.shared.showAlertWith(Title: "", Message: "Data Deleted successfully", onVC: self)
            }
            else
            {
                VGUtility.shared.showAlertWith(Title: "", Message: "Data Not Deleted", onVC: self)
            }
        }
    }
}
//Table view custom cell
class clsCitylistCell: UITableViewCell
{
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var viwBG : UIView!
}
//text feild delegate method
extension HomeVC : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if updatedText == ""
            {
                self.arrSearchCity = self.arrCity
            }
            else
            {
                self.arrSearchCity = self.arrCity.filter
                { ent in
                    ent.strCity.capitalized.contains(updatedText.capitalized) || ent.strLocality.capitalized.contains(updatedText.capitalized) || ent.strCountry.capitalized.contains(updatedText.capitalized) || ent.strPostalCode.capitalized.contains(updatedText.capitalized)
                }
            }
            self.tblBookmarkCity.reloadData()
        }
        return true
    }
}
