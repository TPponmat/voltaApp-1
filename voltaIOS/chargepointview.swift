//
//  chargepointview.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftyJSON
import Alamofire

class chargepointview: UIViewController {

    @IBOutlet weak var cpid_lb: UILabel!
    @IBOutlet weak var datetime_lb: UILabel!
    @IBOutlet weak var time_lb: UILabel!
    @IBOutlet weak var start_btn: UIButton!
    @IBOutlet weak var mainmenu_btn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accessTokenString: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        let refreshTokenString: String? = KeychainWrapper.standard.string(forKey: "refreshToken")
        let chargeIDString: String? = KeychainWrapper.standard.string(forKey: "chargeID")
        
        cpid_lb.text = chargeIDString!
        getCurrentDate()
        getCurrentTime()
        
        
    }
    
    // MARK : Function
    func getCurrentDate(){
        
        let formatter = DateFormatter()
        //        formatter.dateStyle = .long
        //        formatter.timeStyle = .medium
        formatter.dateFormat = "dd-MMM-yyyy"
        let date_str = formatter.string(from: Date())
        datetime_lb.text = date_str
    }
    
    func getCurrentTime(){
        
        let formatter = DateFormatter()        //        formatter.dateStyle = .long
        //        formatter.timeStyle = .medium
        formatter.dateFormat = "HH:mm a"
        let date_str = formatter.string(from: Date())
        time_lb.text = date_str
    }
    
    
    
    
    //MARK :Action
    
    @IBAction func start_charge_pressed(_ sender: UIButton) {
        
        let chargeIDString: String? = KeychainWrapper.standard.string(forKey: "chargeID")
        let accessTokenString: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        
        let parameter :[String : Any] = [
            "chargeid" : chargeIDString!,
            "command" : "STATUS_ON"
        ]
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization" : "Bearer \(accessTokenString!)"]
        
        Alamofire.request("http://192.168.1.41:5000/api/active", method: .post , parameters: parameter as Parameters, encoding: JSONEncoding.default, headers : header ).responseJSON { (responseData) -> Void in
            if(responseData.response?.statusCode == 200){
            
                DispatchQueue.main.async {
                    let stoppage = self.storyboard?.instantiateViewController(withIdentifier: "stopchargeview") as! stopchargeview
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = stoppage
                    
                }
        
            }
                
        
        
        
    }
    
    

}
    
    @IBAction func mainmenu_pressed(_ sender: UIButton) {
    
        DispatchQueue.main.async {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "sidebarview") as! sidebarview
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = page
            
        }
    
    
    }
    
    

}
