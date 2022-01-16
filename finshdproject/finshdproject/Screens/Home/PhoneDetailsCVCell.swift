//
//  PhoneDetailsCVCell.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 03/05/1443 AH.
//

import UIKit
import SDWebImage


class PhoneDetailsCVCell: UICollectionViewCell {
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var imgCllPhone: UIImageView!
  @IBOutlet weak var labelPhoneCell: UILabel!
  @IBOutlet weak var labelCellDisCrbion: UILabel!
  @IBOutlet weak var cartButton: UIButton!
  
  
  // MARK: - functions
  
  func Setupcell (photo:String ,
                  price:Double,
                  DisCrbsion:String){
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    imgCllPhone.sd_setImage(with: URL(string: photo),
                            placeholderImage: animatedImage)
    labelPhoneCell.text = "\(price) SAR"
    labelCellDisCrbion.text = DisCrbsion
  }
}


