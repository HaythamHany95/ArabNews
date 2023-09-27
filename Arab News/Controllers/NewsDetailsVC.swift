//
//  NewsDetailsVC.swift
//  Arab News
//
//  Created by Haytham on 24/09/2023.
//

import UIKit
import WebKit

class NewsDetailsVC: UIViewController {
    
    var newsUrl: String?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var newsUrlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        navigationController?.navigationBar.tintColor = .label

    }
    
    func customizeUI() {
        newsUrlLabel.text = newsUrl
        
        guard NSURL(string: newsUrl ?? "") != nil else {
            
            print("Url not found")
            return
        }
        webView.load(NSURLRequest(url: NSURL(string: newsUrl ?? "")! as URL ) as URLRequest)

    }
}
