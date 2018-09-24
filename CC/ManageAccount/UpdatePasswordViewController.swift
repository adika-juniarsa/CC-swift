//
//  UpdatePasswordViewController.swift
//  CC
//
//  Created by febi on 9/14/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit
import Defaults

class UpdatePasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if !checkUserSession(){
//            let thisStoryboard = UIStoryboard(name: "MainLogin", bundle: nil)
//            let controller = thisStoryboard.instantiateViewController(withIdentifier: "MainLoginPage")
//            self.navigationController?.pushViewController(controller, animated: true)
//            
////            self.performSegue(withIdentifier: "mainLoginSegue", sender: nil)
//        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
