//
//  HomeVC.swift
//  1-2-Dine
//
//  Created by God on 31/01/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

let reuseIdentifier = "HomeCVC"
class HomeVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var demoImageView: UIImageView!
    var tableData: [Any] = []
    var tableArray: [Any] = []
    var imageURL : [String] = []
    var restaurantName : [String] = []
    var dataDict = [:] as NSDictionary
    
//var planeFound: [AnyHashable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(true, animated: true)
        apiRestaurants()
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
        
//         demoImageView.sd_setImage(with: URL(string: "https://asernv.org/file/thumbnail?filename=/Lighthouse.jpg"), placeholderImage: UIImage(named: "dummy.jpg"))
//        tableData = ["bikanerwala.jpeg", "burger.jpeg", "haldiram.png", "bikanerwala.jpeg", "burger.jpeg", "haldiram.png","bikanerwala.jpeg", "burger.jpeg", "haldiram.png", "bikanerwala.jpeg", "burger.jpeg", "haldiram.png"]
        // Do any additional setup after loading the view.
    }
    
    // Api Calling
    
    func apiRestaurants(){
        
        Proxy.shared.showActivityIndicator()
        let url = "\(Apis.KServerUrl)\(Apis.Krestaurants)" // This will be your link
        print(url)
        let param: [String: Any] = [
            
            "lat": "28.5736914",
            "long": "77.3145706"
                    ]
        
        Alamofire.request("\(Apis.KServerUrl)\(Apis.Krestaurants)", method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result{
                
            case .success:
                Proxy.shared.hideActivityIndicator()
                let dict = response.value as! NSDictionary
                print(dict)
                
                let dataArray = dict.value(forKey: "data") as! NSDictionary
                print(dataArray)
                
                self.tableArray = (dataArray.value(forKey: "restaurant_details") as! NSArray) as! [Any]
                for item in self.tableArray {
                    self.dataDict = item as! NSDictionary
                    print(self.dataDict)
                    self.imageURL.append(self.dataDict.value(forKey: "image") as! String)
                    self.restaurantName.append(self.dataDict.value(forKey: "name") as! String)
                }
                
                
                self.collectionView.delegate = self
                self.collectionView.dataSource = self

                print(self.tableArray)
                Proxy.shared.hideActivityIndicator()
//                let email = dataArray1.object(forKey: "email") as! String
//                print(email)
//                Proxy.shared.pushToNextVC(identifier: "HomeVC", isAnimate: true, currentViewController: self)
                
                
            case .failure(let error):
                Proxy.shared.hideActivityIndicator()
                print(error.localizedDescription)
                
            }
        }
        
    }
    
    
    
    
    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.tableArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! HomeCVC
       
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.orange.cgColor
//        cell.contentView.layer.shadowColor = UIColor.orange.cgColor
        cell.layer.shadowColor = UIColor.orange.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
//        (roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
//        cell.layer.backgroundColor = UIColor.purple.cgColor
        
        
       
        
//        print(dict)
        cell.cellImage.sd_setImage(with: URL(string: imageURL[indexPath.row]), placeholderImage: UIImage(named: "dummy.jpg"))
        
//        cell.cellImage.image = UIImage(named: tableData[indexPath.row] as? String ?? "")
        
        //        cell.backgroundColor = self.randomColor()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (collectionView.bounds.size.width / 2) - 5, height: collectionView.bounds.size.height/4) //350
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = self.restaurantName[indexPath.row]
        print(name as Any)
        Proxy.shared.pushToNextVC(identifier: "ItemListVC", isAnimate: true, currentViewController: self)
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
