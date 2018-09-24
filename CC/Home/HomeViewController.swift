//
//  ViewController.swift
//  CC
//
//  Created by febi on 9/4/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit
import Defaults
import KeychainSwift

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getKeychain()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    
    @IBAction func earnRewardsBtnAction(_ sender: UIButton) {
        
        if defaults[.isLoggedin]{
            self.performSegue(withIdentifier: "earnRewardSegue", sender: nil)
        }else{
            self.performSegue(withIdentifier: "mainLoginSegue", sender: nil)
        }
        //using this to using identify segue
        
    }
    
    func getKeychain(){
        let keychain = KeychainSwift()
        
        if((keychain.get(Constant.URL.KEYCHAINCC) == nil)){
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            
            let parameters = ["appkey": Constant.URL.APPKEY]
            AFWrapper.sharedInstance.requestGETURL(Constant.APICALL.KEYCHAIN_GENERATE, params: parameters as [String : AnyObject], success: { (json) in
                let data = GenerateKeychain.init(json: json)
                
                if data.status!{
                    keychain.set(data.keychainValue!, forKey: Constant.URL.KEYCHAINCC)
                }else{
                    Alert.showAlert(title: "", message: "error data message")
                }
                
            }) { (error) in
                
            }
            
            self.view.activityStopAnimating()
        }
    }
}

