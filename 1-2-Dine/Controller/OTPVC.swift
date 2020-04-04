//
//  OTPVC.swift
//  1-2-Dine
//
//  Created by God on 29/01/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//

import UIKit



var token : String?

class OTPVC: UIViewController, UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var otpText4: UITextField!
    @IBOutlet weak var otpText3: UITextField!
    @IBOutlet weak var otpText2: UITextField!
    @IBOutlet weak var otpText1: UITextField!

    @IBOutlet weak var emailId: UILabel!
    var otp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailId.text = token
        otpText1.delegate=self
        otpText2.delegate=self
        otpText3.delegate=self
        otpText4.delegate=self
        
        otpText1.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc func gestureAction(_ sender : UIGestureRecognizer)  {
        self.view.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.text!.count < 1  && string.count > 0{
            let nextTag = textField.tag + 1
            
            // get next responder
            var nextResponder = textField.superview?.viewWithTag(nextTag)
            
            if (nextResponder == nil){
                
                nextResponder = textField.superview?.viewWithTag(4)
            }
            textField.text = string
            nextResponder?.becomeFirstResponder()
            if nextTag == 5 {
                if otpText4.text?.count == 1 {
                    print("nxt")
                    let str = otpText1.text! + otpText2.text! + otpText3.text! + otpText4.text!
                    print("str \(str)")
                    otp=str
//                    self.confirmOTP()
                print(otp)
                }
            }
            return false
        }
        else if textField.text!.count >= 1  && string.count == 0{
            // on deleting value from Textfield
            let previousTag = textField.tag - 1
            
            // get next responder
            var previousResponder = textField.superview?.viewWithTag(previousTag)
            
            if (previousResponder == nil){
                previousResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        }
        return true
    }

    @IBAction func submitAction(_ sender: Any) {
        
        Proxy.shared.pushToNextVC(identifier: "HomeVC", isAnimate: true, currentViewController: self)
    }
    
    @IBAction func backAction(_ sender: Any) {
        Proxy.shared.popToBackVC(isAnimate: true, currentViewController: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
