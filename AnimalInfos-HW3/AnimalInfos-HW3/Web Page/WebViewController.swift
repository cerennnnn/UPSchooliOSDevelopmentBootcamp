//
//  WebViewController.swift
//  AnimalInfos-HW3
//
//  Created by Ceren Güneş on 15.07.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: urlString!)!))
    }
}
