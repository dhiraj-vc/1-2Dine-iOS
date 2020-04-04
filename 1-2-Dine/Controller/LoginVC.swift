//
//  LoginVC.swift
//  1-2-Dine
//
//  Created by God on 29/01/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class LoginVC: UIViewController,GIDSignInDelegate {

    @IBOutlet weak var emailId: UITextField!
    
    @IBOutlet weak var pswdTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var rgisterBtn: UILabel!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var faceBookBtn: UIButton!
    
    @IBOutlet weak var forgotPswdBtn: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        if emailId.text!.isEmpty || pswdTxt.text!.isEmpty{
        
       Proxy.shared.SubmitAlertView(viewController: self, title: "Error", message: "One of either field is empty")
        }else{
            APILogin()
        }
    }
    

    
    @IBAction func GoogleAction(_ sender: Any) {
//        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController=self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate=self
//        GIDSignIn.sharedInstance().uiDelegate=self
        
    }
    @IBAction func FacebookAction(_ sender: Any) {
        let loginManager = LoginManager()
       
//        loginManager.logIn(permissions: ["public_profile"], from: self, handler: { result, error in
//            if error != nil {
//                print("Process error")
//            } else if result?.isCancelled != nil {
//                print("Cancelled")
//            } else {
//                print("Logged in")
//            }
//        })

    
        loginManager.logIn(
            permissions: ["publicProfile", "email"],
            from: self, handler: { result, error in
                            if error != nil {
                                print("Process error")
                            } else if result?.isCancelled != nil {
                                print("Cancelled")
//                                Proxy.shared.pushToNextVC(identifier: "HomeVC", isAnimate: true, currentViewController: self)
                            } else {
                                print("Logged in")
                                Proxy.shared.pushToNextVC(identifier: "HomeVC", isAnimate: true, currentViewController: self)
                            }
                        })
        
    }
    
    
    func APILogin(){
        let mailId = emailId.text
        let password = pswdTxt.text
        
        Proxy.shared.showActivityIndicator()
        let url = "\(Apis.KServerUrl)\(Apis.KLogin)" // This will be your link
        print(url)
        let param: [String: Any] = [
            "email": mailId!,
            "password" : password!
        ]
        
        Alamofire.request("\(Apis.KServerUrl)\(Apis.KLogin)", method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
         
            switch response.result{
                
            case .success:
               Proxy.shared.hideActivityIndicator()
                let dict = response.value as! NSDictionary
                print(dict)
               
                let dataArray = dict.value(forKey: "success") as! NSDictionary
                print(dataArray)
               
                let dataArray1 = dataArray.object(forKey: "user details") as! NSDictionary
               
                print(dataArray1)
               
                let email = dataArray1.object(forKey: "email") as! String
                print(email)
                 Proxy.shared.pushToNextVC(identifier: "HomeVC", isAnimate: true, currentViewController: self)
                
                
            case .failure(let error):
                Proxy.shared.hideActivityIndicator()
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        Proxy.shared.pushToNextVC(identifier: "HomeVC", isAnimate: true, currentViewController: self)
        // ...
    }

    
    @IBAction func forgotPswdAction(_ sender: Any) {
        Proxy.shared.pushToNextVC(identifier: "ForgotPasswordVC", isAnimate: true, currentViewController: self)
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        
        Proxy.shared.pushToNextVC(identifier: "CreateAccountVC", isAnimate: true, currentViewController: self)
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
