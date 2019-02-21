//
//  signupview.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit

class signupview: UIViewController {

    //MARK : Property
    
    @IBOutlet weak var signup_btn: UIButton!
    @IBOutlet weak var signin_btn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK : Action
    
    @IBAction func signup_pressed(_ sender: UIButton) {
        
        print("Sign Up Pressed")
        DispatchQueue.main.async {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "signuppage") as! signuppage
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = page
            
        }
        
        
    }
    
    @IBAction func signin_pressed(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "signinpage") as! signinpage
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = page
            
        }
        
        
    }
    
    
    
    
}
