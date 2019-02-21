//
//  ViewController.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let header : HTTPHeaders = ["Content-Type" :"application/json"]
        //
        //
        Alamofire.request("http://192.168.1.41:5000/", method: .get, encoding: JSONEncoding.default, headers : header ).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil){
                
                print("Server Online !!!")
                
            }
            if(responseData.response?.statusCode == 200){
                
                print("Return 200")
                
                DispatchQueue.main.async {
                    let homepage = self.storyboard?.instantiateViewController(withIdentifier: "signupview") as! signupview
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = homepage
                    
                }
                
                
                
            }
            //
            //
            
            
        }
        
        
    }
    
}

