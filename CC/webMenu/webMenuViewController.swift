//
//  webMenuViewController.swift
//  CC
//
//  Created by febi on 9/5/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit
import WebKit

class webMenuViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webPage: WKWebView!
    @IBOutlet weak var Loader: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        Loader.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let myURL = URL(string: Constant.URL.MENU_URL)
        let myRequest = URLRequest(url: myURL!)
        webPage.navigationDelegate = self
        webPage.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backNavigate(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        Loader.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Loader.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Loader.startAnimating()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
