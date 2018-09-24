//
//  ManageAccountViewController.swift
//  CC
//
//  Created by febi on 9/12/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit
import Defaults

class ManageAccountViewController: UIViewController {
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var labelSigned: UILabel!
    @IBOutlet var labelEmail: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        checkSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sideMenuPressed(_ sender: UIButton) {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    

    @IBAction func updatePasswordPressed(_ sender: UIButton) {
        if checkUserSession(){
            let updateController = storyboard!.instantiateViewController(withIdentifier: "update password page")
            self.navigationController?.pushViewController(updateController, animated: true)
        }else{
            let thisStoryboard = UIStoryboard(name: "MainLogin", bundle: nil)
            let mainLogincontroller = thisStoryboard.instantiateViewController(withIdentifier: "MainLoginPage")
    
            let updateController = storyboard!.instantiateViewController(withIdentifier: "update password page")
    
            if var navstack = navigationController?.viewControllers{
                navstack.append(contentsOf: [updateController,mainLogincontroller])
                navigationController?.setViewControllers(navstack, animated: true)
            }
        }
    
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if checkUserSession(){
            logoutCall()
        }else{
            self.performSegue(withIdentifier: "mainLoginSegue", sender: nil)
        }
    }
    
    
    func checkSession(){
        if checkUserSession(){
            loginBtn.setImage(UIImage(named: "log_out"), for: UIControlState.normal)
            labelEmail.text = defaults[.user_name]
            
            labelEmail.isHidden = false
            labelSigned.isHidden = false
        }else{
            loginBtn.setImage(UIImage(named: "log_in"), for: UIControlState.normal)
            
            labelEmail.isHidden = true
            labelSigned.isHidden = true
        }
    }
    
    func logoutCall(){
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        
        let parameters : [String:String] = [
            "appkey": Constant.URL.APPKEY,
            "auth_token": defaults[.user_auth]
        ]
        
        AFWrapper.sharedInstance.requestGETURL(Constant.APICALL.LOOUT, params: parameters as [String : AnyObject], success: { (json) in
            
            self.view.activityStopAnimating()
            
            let data = Logout.init(json: json)
            
            if data.status!{
                Alert.showAlert(title: "", message: data.notice!)
                
                defaults[.user_auth].removeAll()
                defaults[.user_name].removeAll()
                defaults[.isLoggedin] = false
                
                self.checkSession()
            }else{
                
            }
            
        }) { (error) in
            
        }
        
    }
    
    
}
