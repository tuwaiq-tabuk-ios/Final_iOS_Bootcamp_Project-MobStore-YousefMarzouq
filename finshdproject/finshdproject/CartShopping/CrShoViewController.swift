//
//  CrShoViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 17/05/1443 AH.


import UIKit
import Metal

class CrShoViewController: UIViewController,
                           UICollectionViewDelegate,
                           UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout{
  
  var arri2:[Prodects]! = [Prodects]()
  var arr:[Prodects]!
  var selectBrand:String!
  
  
  @IBOutlet weak var viewGreen: UIView!
  @IBOutlet weak var contToBuy: UIButton!
  @IBOutlet weak var labelTootl: UILabel!
  @IBOutlet weak var CollcshinCaSho: UICollectionView!
  @IBOutlet weak var totllAount: UILabel!
  @IBOutlet weak var nothingImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    CollcshinCaSho.delegate = self
    CollcshinCaSho.dataSource = self
    
    if arri2.count == 1 {
      CollcshinCaSho .isHidden = true
      totllAount.isHidden = true
      labelTootl.isHidden = true
      contToBuy.isHidden = true
      viewGreen.isHidden = true
    } else {
      nothingImage.isHidden = true
    
    }
    
 
  
  
  }
  
  @IBAction func rmoveItm(_ sender: UIButton) {
    dismiss(animated: true, completion: nil);
  }
  
  @IBAction func ContTobuy (_ sender: UIButton) {
  }
  
//  var conter = 1
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 10
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = CollcshinCaSho.dequeueReusableCell(withReuseIdentifier: "CaSho", for: indexPath) as! CrShoCollectionViewCell
    cell.imgShoCr.image = UIImage(named: "12mini") //arri2[indexPath.row].image
    cell.plasPressd.tag = indexPath.row
    cell.muensPressd.tag = indexPath.row
    cell.conttiCrSho.tag = indexPath.row
    cell.rmove.tag = indexPath.row
    cell.conttiCrSho.text = "1"
    cell.labelDitels.text = "Apple-12 mini-128 hgfdjkl;';lkjhgsfdhfjgkhlj"
    cell.labelPricShoCr.text = "6500 SR"
//    
    return cell
    
  }
  
  
  @IBAction func pluseButtonmPreased(_ sender: UIButton) {
    let cell = CollcshinCaSho!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CrShoCollectionViewCell
    var conter = Int(cell.conttiCrSho.text!)
    conter! += 1
    cell.conttiCrSho.text = conter?.description
  }
  
  
  @IBAction func minusButtonPreased(_ sender: UIButton) {
    
    let cell = CollcshinCaSho!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CrShoCollectionViewCell
    var conter = Int(cell.conttiCrSho.text!)
    if conter != 0 {
      conter! -= 1
      cell.conttiCrSho.text = conter?.description

    }
  }
  
  
}
