//
//  MainLoginViewController.swift
//  CC
//
//  Created by febi on 9/6/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit

class MainLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if let viewControllers = self.navigationController?.viewControllers {
            for vc in viewControllers {
                if vc.isKind(of: UpdatePasswordViewController.classForCoder()){
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);

                    return
                }
            }
        }else{
            self.navigationController?.popViewController(animated: true);
        }
    
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
