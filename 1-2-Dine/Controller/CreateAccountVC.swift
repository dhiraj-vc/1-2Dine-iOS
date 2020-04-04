//
//  CreateAccountVC.swift
//  1-2-Dine
//
//  Created by God on 27/01/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//

import UIKit
import Alamofire

class CreateAccountVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var pswdTxt: UITextField!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var phoneNumTxt: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func registorAction(_ sender: Any) {
        
        if nameTxt.text!.isEmpty{
            
            Proxy.shared.SubmitAlertView(viewController: self, title: "Error", message: "Name Field is empty")
            return
        }else if emailTxt.text!.isEmpty{
            Proxy.shared.SubmitAlertView(viewController: self, title: "Error", message: "Email Field is empty")
            return
        }else if pswdTxt.text!.isEmpty{
            Proxy.shared.SubmitAlertView(viewController: self, title: "Error", message: "Password Field is empty")
            return
        }else if countryTxt.text!.isEmpty{
            Proxy.shared.SubmitAlertView(viewController: self, title: "Error", message: "Please select country.")
            return
        }else if phoneNumTxt.text!.isEmpty{
            Proxy.shared.SubmitAlertView(viewController: self, title: "Error", message: "Please add your contact number.")
            return
        }else{
            createAccountAPI()
        }
        
        
    }
    
    
    func createAccountAPI(){
       
        let fullName  = nameTxt.text!
        let password = pswdTxt.text!
        let cPassword = pswdTxt.text!
        let email = emailTxt.text!
        let phoneNo = phoneNumTxt.text!
        let country = countryTxt.text!
        
        Proxy.shared.showActivityIndicator()
        let url = "\(Apis.KServerUrl)\(Apis.Kregister)" // This will be your link
        print(url)
        let param: [String: Any] = [
            "full_name" : fullName,
            "email" : email,
            "password" : password,
            "phone_number" : phoneNo,
            "country" : country,
            "c_password" : cPassword
            
        ]
        print(param)
        
        Alamofire.request("\(Apis.KServerUrl)\(Apis.Kregister)", method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result{
                
            case .success:
                Proxy.shared.hideActivityIndicator()
                let dict = response.value as! NSDictionary
                print(dict)
                
                let dataArray = dict.value(forKey: "success") as! NSDictionary
                print(dataArray)
                
//                let dataArray1 = dataArray.object(forKey: "user details") as! NSDictionary
                
//                print(dataArray1)
                
                let email = dataArray.object(forKey: "email") as! String
                print(email)
                token = email
                Proxy.shared.pushToNextVC(identifier: "OTPVC", isAnimate: true, currentViewController: self)
     
                
            case .failure(let error):
                Proxy.shared.hideActivityIndicator()
                print(error.localizedDescription)
                
            }
        }
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
