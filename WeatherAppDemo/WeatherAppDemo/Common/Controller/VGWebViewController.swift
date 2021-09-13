//
//  VGWebViewController.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit
import WebKit

class VGWebViewController: UIViewController , WKNavigationDelegate ,WKUIDelegate
{

    //MARK: - IBOutlets
    var webView: WKWebView!
    @IBOutlet weak var viwActivity: UIActivityIndicatorView!
    //MARK: - Variable declaration
    var urlToLoad: String?
    
    var bisHTMLContent = false
    //MARK: - View life cycle methods
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setControllerPreference()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.webView.scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    func setControllerPreference(){
        if bisHTMLContent == true // static string
        {
            //webView1.loadHTMLString("<html><body><p>Hello!</p></body></html>", baseURL: nil)
            
            webView.loadHTMLString("<html><body><p style='font-size:50px'>\(urlToLoad ?? "")</p></body></html>", baseURL: nil)
            self.navigationController?.navigationBar.isHidden = false
        }
        else //display url
        {
            if let url = URL(string: urlToLoad ?? "")
            {
//                let url = URL(string: "https://www.hackingwithswift.com")!
                webView.load(URLRequest(url: url))
                webView.allowsBackForwardNavigationGestures = true
            }
        }
    }
    

    
    //MARK : - WK web view delegate method
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityIndicator()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let changeFontFamilyScript = "document.getElementsByTagName(\'body\')[0].style.fontFamily = \"Impact,Charcoal,sans-serif\";"
                webView.evaluateJavaScript(changeFontFamilyScript) { (response, error) in
                    debugPrint("Am here")
                }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideActivityIndicator()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    //MARK: - Activity methods
    
    // Method to Show activity indicator
    func showActivityIndicator()
    {
//        viwActivity.startAnimating()
//        self.showLoader()
    }
    
    // Method to hide activity indicator
    func hideActivityIndicator()
    {
//        viwActivity.stopAnimating()
//        self.hideLoader()
    }
    
}
