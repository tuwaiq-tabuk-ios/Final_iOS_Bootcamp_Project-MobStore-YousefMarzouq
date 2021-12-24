//
//  PhoneDitelsCollectionViewCell.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 03/05/1443 AH.
//

import UIKit

class PhoneDitelsCollectionViewCell: UICollectionViewCell {
    
  
  
  @IBAction func likeall(_ sender: UIButton) {
  }
  
  @IBOutlet weak var imgCllPhone: UIImageView!
  
  
  @IBOutlet weak var labelPhoneCell: UILabel!
  
  
  @IBOutlet weak var labelCellDisCrbion: UILabel!
  
  @IBOutlet weak var banddImg: UIImageView!
  
  
  func Setupcell (photo:UIImage , price:Double, DisCrbsion:String){
    imgCllPhone.image = photo
    labelPhoneCell.text = "\(price) SAR"
    labelCellDisCrbion.text = DisCrbsion
  }
  
}


