//
//  SideMenuViewController.swift
//  CC
//
//  Created by febi on 9/4/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit
import Defaults
import LGSideMenuController

extension Defaults.Keys{
    static let user_auth = Defaults.Key<String>("user_auth", default: "-1")
    static let user_name = Defaults.Key<String>("user_name", default: "-1")
    static let device_token = Defaults.Key<String>("device_token", default: "")
    static let isLoggedin = Defaults.Key<Bool>("isLoggedin", default: false)
    static let latitude = Defaults.Key<Double>("latitude", default: 0.0)
    static let longitue = Defaults.Key<Double>("longitue", default: 0.0)
}

class SideMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HomeBtnPressed(_ sender: UIButton) {
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController as! LGSideMenuController
        let navigationController = mainViewController.rootViewController as! UINavigationController
        
        let thisStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = thisStoryboard.instantiateViewController(withIdentifier: "homePage") as! HomeViewController
        
        navigationController.pushViewController(rootViewController, animated: false)
        mainViewController.hideLeftView(animated: true, completionHandler: nil)
    }
    
    @IBAction func manageAccountPressed(_ sender: UIButton) {
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController as! LGSideMenuController
        let navigationController = mainViewController.rootViewController as! UINavigationController
        
        let thisStoryboard = UIStoryboard(name: "ManageAccountSB", bundle: nil)
        let rootViewController = thisStoryboard.instantiateViewController(withIdentifier: "ManageAccountView") as! ManageAccountViewController
        
        navigationController.pushViewController(rootViewController, animated: false)
        mainViewController.hideLeftView(animated: true, completionHandler: nil)
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
