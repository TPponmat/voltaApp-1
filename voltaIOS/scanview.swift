//
//  scanview.swift
//  voltaIOS
//
//  Created by Nontachai Yoothai on 21/2/2562 BE.
//  Copyright © 2562 Nontachai Yoothai. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftyJSON
import Alamofire
import AVFoundation

class scanview: UIViewController , AVCaptureMetadataOutputObjectsDelegate{

    @IBOutlet weak var mainmenu_btn: UIButton!
    @IBOutlet weak var scanqr_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let accessTokenString: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        let refreshTokenString: String? = KeychainWrapper.standard.string(forKey: "refreshToken")


    }
    
    @IBAction func scanqr_pressed(_ sender: UIButton) {
        
        print("Call QR Code SCAN Function")
        
        var video = AVCaptureVideoPreviewLayer()
        let session = AVCaptureSession()
        let captureDevice = AVCaptureDevice.default(for: .video)
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        session.startRunning()
    
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    
                    let qrcode = object.stringValue
                    let saveSuccessful: Bool = KeychainWrapper.standard.set(qrcode!, forKey: "chargeID")
                    DispatchQueue.main.async
                        {
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "chargepointview") as! chargepointview

                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func main_menu(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "sidebarview") as! sidebarview
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = page
            
        }

        
    }
    
    
    
    
}
