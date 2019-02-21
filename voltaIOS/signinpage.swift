//
//  signinpage.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class signinpage: UIViewController {

    @IBOutlet weak var login_btn: UIButton!
    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var username_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    
    @IBAction func back_btn_pressed(_ sender: UIButton) {
    
        
        DispatchQueue.main.async {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "signupview") as! signupview
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = page
            
        }
    
    }
    
    @IBAction func login_btn_pressed(_ sender: UIButton) {
    
        
        if(password_txt.text != "" && username_txt.text != "") {
        
        
            let parameter :[String : Any] = [
                                             "passwd" : password_txt.text!,
                                             "login" : username_txt.text!
                                             ]
            let header : HTTPHeaders = ["Content-Type" : "application/json"]
            
            Alamofire.request("http://192.168.1.41:5000/token/login", method: .post , parameters: parameter as Parameters, encoding: JSONEncoding.default, headers : header ).responseJSON { (responseData) -> Void in
                    if(responseData.response?.statusCode == 200){
                        
                        print("Return 200 in Registration")
                        
                        
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        let access_token = swiftyJsonVar["access_token"]
                        let refresh_token = swiftyJsonVar["refresh_token"]
                        
                        // Add access token to keychain
                        do {
                            let accessToken_flag : Bool = KeychainWrapper.standard.set("\(access_token)", forKey: "accessToken")
                            let refreshToken_flag : Bool = KeychainWrapper.standard.set("\(refresh_token)", forKey: "refreshToken")
                            
                            if (accessToken_flag == true && refreshToken_flag == true){ // Change Condition to Status Code
                                
                                // Redirect to Another View
                                DispatchQueue.main.async
                                    {
                                        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "scanview") as! scanview
                                        
                                        let appDelegate = UIApplication.shared.delegate
                                        appDelegate?.window??.rootViewController = homePage
                                    }
                            }
                            
                        }

                    }
                
                }
        }
        
    }
        
}
    
    
    

