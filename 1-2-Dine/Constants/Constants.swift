//
//  OTPVC.swift
//  1-2-Dine
//
//  Created by God on 29/01/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//import Foundation
import UIKit
//BORDER : E8E8E8
//BACKGROUND : FAFAFA
enum AppInfo {
    static let Mode       = ""
    static let AppName    = ""
    static let Version    = ""
    static let DeviceType = ""
    static let DeviceName = UIDevice.current.name
    static let ZoomLevel  = Float(14.0)
    static let UserAgent  = "\(Mode)/\(AppName)/\(Version)"
    static let EmergencyNo = "911"
}


enum StaticData {
    static let GenderArray  = ["Male", "Female","Others"]
    static let ArrBool      = [["Yes",0],["No",1]]
 
}
enum BoolVal :Int{
    case FALSE = 0,TRUE
}
enum AppKeys{
    static let GoogleService = "AIzaSyDHkpVIkBLLdfk7vl-qGOM5B3I5CYZfNjo"
    static let GooglePlaces  = "AIzaSyCRhKPMIZLGkzneoI6oQgyfH52D9_Fe-II"
}
enum Colours{
    static let AppColor          = UIColor(red: 114/255, green: 3/255, blue: 3/255, alpha: 1)
    static let PopUpColor        = UIColor(red: 114/255, green: 3/255, blue: 3/255, alpha:0.5)
    static let SuccessColor      = UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1.0)
    static let DisbaleButtonColo = UIColor(red: 78/255, green: 177/255, blue: 217/255, alpha: 0.6)
    static let lightGreyColor    = UIColor (red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 1.0)
    static let buttonFrndColor   = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1.0)
    static let PlaceHolderColor  = UIColor(red: 132.0/255.0, green: 132.0/255.0, blue: 132.0/255.0, alpha: 1.0)
}
enum Apis {
 //MARK : COMMON APIS
//    static let KServerUrl       = "http://jupiter.toxsl.in/aser/api/"
    static let KServerUrl       = "http://13.127.253.155/dine/api"
    static let KLogin           = "/login"
    static let Kregister        = "/register"
    static let Krestaurants     = "/restaurants"

    
    }
enum Gender: Int {
    case Male = 0,Female
}


enum UserRole:Int {
    case Admin = 1, User,Medical,Patient
}
enum UserStatus : Int {
    case InActive = 0, Complete, Incomplete
}
enum AppointmentState : Int {
    case InActive = 0, Active, Pending, Complete
 }
enum GalleryType {
    static let KGallery = "Gallery"
    static let KCamera  = "Camera"
    static let KCancel  =  "Cancel"
}
enum TitleValue {
    static let setting         = "Settings"
    static let cancel          = "Cancel"
    static let deletePhoto     = "Delete Photo"
    static let choosePhoto     = "Choose Photo"
    static let takePhoto       = "Take Photo"
    static let alert           = "Alert"
    static let ok              = "Ok"
    static let REMOVEPARTICIPANTS =  "Remove Participants?"
    static let UNATTENDEDSURVEY   = "Unattended Survey"
}

enum AlertMsgs {
    //MARK : SELECT MESSGES
    static let KEMAILSENT      = "Mail successfully sent"
    
}
enum WebPage:Int{
    case ABOUT_US = 0, GUIDELINES, PRIVACY, TERMS
}
enum Options:Int{
    case  NO_OPTION = 0, MULTIPLE, CHOOSE_ONE, TYPE_ANS    
}

struct ApiResponse {
    var data: NSDictionary?
    var success: Bool
    var message: String?
}

struct ApiResponse2 {
    var success : String
    var urlname : String
    var download_link : String
}

var mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

//    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! NextViewController
//    self.present(nextViewController, animated:true, completion:nil)
