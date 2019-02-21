//
//  sidebarview.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON

class sidebarview: UIViewController {

    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var logout_btn: UIButton!
    @IBOutlet weak var privacy_btn: UIButton!
    @IBOutlet weak var payment_btn: UIButton!
    @IBOutlet weak var card_btn: UIButton!
    @IBOutlet weak var myaccount_btn: UIButton!
    
    @IBOutlet weak var name_lb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accessTokenString: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        let refreshTokenString: String? = KeychainWrapper.standard.string(forKey: "refreshToken")
        // Do any additional setup after loading the view.
        
        
        let header : HTTPHeaders = ["Content-Type" :"application/json",
                                    "Authorization" : "Bearer "+accessTokenString!
        ]
        
        // Add Alamofire get User Infomation
        Alamofire.request("http://192.168.1.41:5000/api/getuserinfo", method: .get , encoding: JSONEncoding.default, headers : header ).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil){
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                self.name_lb.text = "\(swiftyJsonVar["name"])"
                
                
            }
            
        }
        
    }
    
    @IBAction func back_btn_pressed(_ sender: Any) {
        
        //Go to scan view
        DispatchQueue.main.async {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "scanview") as! scanview
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = page
            
        }
        
        
    }
    
    @IBAction func logout_pressed(_ sender: Any) {
        //Release Wrapper Key
        
        let access_removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "accessToken")
        let refresh_removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "refreshToken")
        if(access_removeSuccessful && refresh_removeSuccessful) {
            
            //Go to SignupView
            
            DispatchQueue.main.async {
                let page = self.storyboard?.instantiateViewController(withIdentifier: "signupview") as! signupview
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = page
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
}
