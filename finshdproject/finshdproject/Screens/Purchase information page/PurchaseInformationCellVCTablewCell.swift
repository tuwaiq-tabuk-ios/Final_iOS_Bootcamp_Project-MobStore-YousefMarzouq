//
//  PurchaseInformationCellVCTablewCell.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 23/05/1443 AH.
//

import UIKit


class PurchaseInformationCellVCTablewCell: UITableViewCell {

 
  // MARK: - IBOutlet
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!
  
  
  // MARK: - Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
  }
}
