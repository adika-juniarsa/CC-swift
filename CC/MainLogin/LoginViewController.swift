//
//  LoginViewController.swift
//  CC
//
//  Created by febi on 9/6/18.
//  Copyright © 2018 febi. All rights reserved.
//

import UIKit
import ZSWTaggedString
import Validator
import AnyFormatKit
import KeychainSwift
import Defaults
import Async

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInformationLabel()
        phoneField.addDoneButtonOnKeyboard()
        setkeyboardObserver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - button action here
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkBoxBtn(_ sender: UIButton) {
        if (checkBoxBtn.isSelected == true){
            checkBoxBtn.isSelected = false
        }else{
            checkBoxBtn.isSelected = true
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        self.loginCall()
    }
    
}

// MARK: - TextInputDelegate
extension LoginViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 200 // Bool
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textEditingChanged(_ textField: UITextField){
        
        if textField == emailField{
            let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "error"))
            
            let result = emailField.text?.validate(rule: emailRule)
            
            switch result {
            case .valid?: print("yess")
            case .invalid?: print("nooo")
            default: break
            }
        }
        
        if textField == passwordField{
            let passwordRule = ValidationRuleLength(min: 5, error: ValidationError(message: "error"))
            
            let result = passwordField.text?.validate(rule: passwordRule)
            
            switch result {
            case .valid?: print("yess")
            case .invalid?: print("nooo")
            default: break
            }
        }
        
        if textField == phoneField{
            let unformat = unformatPhone(phone: phoneField.text!)
            let phoneFormatter = TextFormatter(textPattern: "####-###-###")
            phoneField.text = phoneFormatter.formattedText(from: unformat)
        }
    }
}

// MARK: - keyboard delegate
extension LoginViewController{
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scroll.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scroll.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scroll.contentInset = contentInset
    }
}

// MARK: - function
extension LoginViewController{
    func setkeyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setInformationLabel(){
        let localizedString = NSLocalizedString("i have read and agree to Relevant mobile's <tou>TERMS OF USE</tou> and <pp>PRIVACY POLICY</pp>.", comment: "");
        let taggedString = ZSWTaggedString(string: localizedString)
        
        let options = ZSWTaggedStringOptions()
        
        options["tou"] = .static([
            .foregroundColor: hexStringToUIColor(hex: "#d72c20")
            ])
        
        options["pp"] = .static([
            .foregroundColor: hexStringToUIColor(hex: "#d72c20")
            ])
        
        
        let attributedString = try! taggedString.attributedString(with: options)
        
        informationLabel.attributedText = attributedString
    }
    
    func loginCall(){
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        
        let keychain = KeychainSwift()
        
        var parameters : [String:String] = [
            "email": emailField.text!,
            "password": passwordField.text!,
            "phone_number": unformatPhone(phone: phoneField.text!),
            "register_type": "1",
            "keychain": keychain.get(Constant.URL.KEYCHAINCC)!,
            "appkey": Constant.URL.APPKEY,
            "migrate": "3"]
        parameters.merge(getDeviceInfo(), uniquingKeysWith: +)
        
        AFWrapper.sharedInstance.requestPOSTURL(Constant.APICALL.LOGIN, params: parameters as [String : AnyObject], success: { (json) in
            
            self.view.activityStopAnimating()
            let data = Login.init(json: json)
            
            if data.status!{
                defaults[.user_name] = self.emailField.text!
                defaults[.user_auth] = data.authToken!
                defaults[.isLoggedin] = true
                
                Alert.showAlert(title: "Success", message: data.notice!){
                    (index) in
                    switch(index){
                    case AlertAction.Ok:
                        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
                    default:
                        break
                    }
                }
            }else{
                Alert.showAlert(title: "", message: data.notice!)
            }
            
        }) { (error) in
            
        }
        
    }
    
}


