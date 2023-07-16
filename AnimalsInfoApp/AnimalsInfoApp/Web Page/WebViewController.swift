//
//  WebViewController.swift
//  AnimalsInfoApp
//
//  Created by Ceren Güneş on 16.07.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString else { return }
        guard let secureURL = URL(string: urlString) else { return }
        webView.load(URLRequest(url: secureURL))
    }
}
