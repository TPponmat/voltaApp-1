//
//  signuppage.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class signuppage: UIViewController {
    
    var endpoint = GlobalVariable.setting.endpoint
    
    @IBOutlet weak var username_txt: UITextField!
    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var mobile_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var repass_txt: UITextField!
    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var done_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK : ACTION !!!
    
    @IBAction func done_pressed(_ sender: UIButton) {
        print("Done Button Pressed")
        
        if(password_txt.text == repass_txt.text){
            
            if((username_txt.text! != "") && (email_txt.text! != "") && (mobile_txt.text! != "") && (password_txt.text! != ""))
            {
            
            
                let parameter :[String : Any] = ["name" : username_txt.text!,
                                                 "email" : email_txt.text!,
                                                 "mobile":mobile_txt.text!,
                                                 "password" : password_txt.text!,
                                                 "login" : email_txt.text!,
                                                 "avatar_path" : "-"]
                let header : HTTPHeaders = ["Content-Type" : "application/json"]
                
                Alamofire.request("\(endpoint)token/register", method: .post , parameters: parameter as Parameters, encoding: JSONEncoding.default, headers : header ).responseJSON { (responseData) -> Void in
                    if(responseData.response?.statusCode == 200){
                    
                    print("Return 200 in Registration")
                    
                        DispatchQueue.main.async {
                            let page = self.storyboard?.instantiateViewController(withIdentifier: "signinpage") as! signinpage
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = page
                            
                        }
                    
                }
                
                }
                
            }
            
        }else{
            
            print("Password Miss Match")
            
        }

        
    }
    
    
    @IBAction func back_pressed(_ sender: Any) {
        DispatchQueue.main.async {
            let homepage = self.storyboard?.instantiateViewController(withIdentifier: "signupview") as! signupview
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = homepage
            
        }
        
    }
    

    
    
    

}
