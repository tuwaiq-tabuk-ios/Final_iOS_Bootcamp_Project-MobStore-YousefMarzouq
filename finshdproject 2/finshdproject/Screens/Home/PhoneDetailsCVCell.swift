//
//  PhoneDetailsCVCell.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 03/05/1443 AH.
//

import UIKit
import SDWebImage


class PhoneDetailsCVCell: UICollectionViewCell {
  
  
  @IBOutlet weak var likeButton: UIButton!
  
  @IBOutlet weak var imgCllPhone: UIImageView!
  
  
  @IBOutlet weak var labelPhoneCell: UILabel!
  
  
  @IBOutlet weak var labelCellDisCrbion: UILabel!
  
  @IBOutlet weak var banddImg: UIImageView!
  
  
  func Setupcell (photo:String ,
                  price:Double,
                  DisCrbsion:String){
    
    
    
    let imageView = SDAnimatedImageView()
    let animatedImage = SDAnimatedImage(named: "Loader1")
    imageView.image = animatedImage
    
    imgCllPhone.sd_setImage(with: URL(string: photo), placeholderImage: imageView.image)
    labelPhoneCell.text = "\(price) SAR"
    labelCellDisCrbion.text = DisCrbsion
  }
  
}


