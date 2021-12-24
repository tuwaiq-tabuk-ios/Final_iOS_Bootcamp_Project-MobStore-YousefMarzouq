//
//  ViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 01/05/1443 AH.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
  
  @IBOutlet weak var collcshinPhoneCell: UICollectionView!
  
  @IBOutlet weak var brandHeaders: UICollectionView!
  
  var arryPhone = [Phne] ()
  
  var arr:[Prodects]!
  var selectedType:String!
  var selectedBrand:String!
  var page:String!

  var arrSeleced:[Prodects] = [Prodects]()
  
  var arrBrand:[String] = [String]()
  
  var selectedProdect:Prodects!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collcshinPhoneCell.delegate = self
    collcshinPhoneCell.dataSource = self
  }
  
  
  
  @IBAction func tollyForPay(_ sender: UIButton) {
  }
  
  
  
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    arr.forEach { Prodectse in
      if page == "Type" {
          if (Prodectse.type == selectedType) {
            arrSeleced.append(Prodects(image: Prodectse.image, info: Prodectse.info, price: Prodectse.price, brand: Prodectse.brand, type: Prodectse.type, Offers: Prodectse.Offers, images: Prodectse.images, isFavorite: false) )
          
        }
    
    
      if !arrBrand.contains(Prodectse.brand) {
      arrBrand.append(Prodectse.brand)
      }
      } else if page == "Brand" {
        if (Prodectse.brand == selectedBrand) {
          arrSeleced.append(Prodects(image: Prodectse.image, info: Prodectse.info, price: Prodectse.price, brand: Prodectse.brand, type: Prodectse.type, Offers: Prodectse.Offers, images: Prodectse.images, isFavorite: false) )
        }
        if !arrBrand.contains(Prodectse.type) {
        arrBrand.append(Prodectse.type)
        }
      } else if page == "ALL" {
        if Prodectse.Offers {
          arrSeleced.append(Prodects(image: Prodectse.image, info: Prodectse.info, price: Prodectse.price, brand: Prodectse.brand, type: Prodectse.type, Offers: Prodectse.Offers, images: Prodectse.images, isFavorite: false) )
      }
        if !arrBrand.contains(Prodectse.brand) {
        arrBrand.append(Prodectse.brand)
        }
      }
    }
    
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == collcshinPhoneCell {
    return arrSeleced.count
    } else {
      return arrBrand.count
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == collcshinPhoneCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneDitels", for: indexPath) as! PhoneDitelsCollectionViewCell
    
    let data = arrSeleced[indexPath.row]
    cell.Setupcell(photo: data.image, price: data.price, DisCrbsion:data.info )
    
    return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandHeader", for: indexPath) as! BrandHeadersCell
      
      cell.name.text = arrBrand[indexPath.row]
      
      return cell
      
    }
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    selectedProdect = arrSeleced[indexPath.row]
    return true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? LastnViewController {
      vc.arri1 = selectedProdect
    }
  }
  
}
