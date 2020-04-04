//
//  ItemListTVC.swift
//  1-2-Dine
//
//  Created by God on 23/03/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//

import UIKit

class ItemListTVC: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    @IBOutlet weak var itemValue: UILabel!
    
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemAddQuantity: UILabel!
    @IBOutlet weak var itemAddBtn: UIButton!
    @IBOutlet weak var itemDeleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
