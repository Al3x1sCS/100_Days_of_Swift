//
//  WebViewController.swift
//  project16
//
//  Created by user on 09/09/22.
//

import WebKit
import UIKit

// challenge 3
class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var website: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard website != nil else {
            print("Website not set")
            navigationController?.popViewController(animated: true)
            return
        }
        
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
        }
    }
    
}
