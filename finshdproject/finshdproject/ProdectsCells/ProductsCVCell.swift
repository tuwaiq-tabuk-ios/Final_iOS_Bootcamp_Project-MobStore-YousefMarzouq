//
//  ProductsCVCell.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 08/05/1443 AH.
//

import UIKit
import SDWebImage


class ProductsCVCell: UICollectionViewCell {
  @IBOutlet weak var imageProdect: UIImageView!
  @IBOutlet weak var infoProdect: UILabel!
  @IBOutlet weak var priceProdect: UILabel!
  
  
  // MARK: - functions

  func Setupcell (photo:String , price:Double, DisCrbsion:String){
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    imageProdect.sd_setImage(with: URL(string: photo), placeholderImage: animatedImage)
    priceProdect.text = "\(price) SAR"
    infoProdect.text = DisCrbsion
  }
  
}
