//
//  ViewController.swift
//  WebView-Safari
//
//  Created by Alexander on 01.08.2021.
//

import UIKit
import WebKit
import SafariServices

class ViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loadSiteInViewButtonPresseed(_ sender: Any) {
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    @IBAction func loadSiteInSafariButtonPressed(_ sender: Any) {
        
        if let url = URL(string: "https://www.apple.com") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

