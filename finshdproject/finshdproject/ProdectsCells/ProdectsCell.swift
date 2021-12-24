//
//  ProdectsCell.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 08/05/1443 AH.
//

import UIKit

class ProdectsCell: UICollectionViewCell {
  @IBOutlet weak var imageProdect: UIImageView!
  @IBOutlet weak var infoProdect: UILabel!
  @IBOutlet weak var priceProdect: UILabel!
  
  func Setupcell (photo:UIImage , price:Double, DisCrbsion:String){
    imageProdect.image = photo
    priceProdect.text = "\(price) SAR"
    infoProdect.text = DisCrbsion
  }
  
}
