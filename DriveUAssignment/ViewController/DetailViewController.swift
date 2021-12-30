//
//  DetailViewController.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import UIKit
import WebKit
class DetailViewController: BaseViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let request = URLRequest(url: URL(string: urlString)!)
        self.webView.navigationDelegate = self
        showLoader()
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoader()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
