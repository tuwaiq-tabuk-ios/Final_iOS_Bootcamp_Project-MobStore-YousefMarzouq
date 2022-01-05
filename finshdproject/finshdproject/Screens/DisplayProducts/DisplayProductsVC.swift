//
//  ViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 01/05/1443 AH.
//

import UIKit
import Firebase

class DisplayProductsVC: UIViewController,
                         UICollectionViewDelegate,
                         UICollectionViewDataSource {
  
  @IBOutlet weak var collcshinPhoneCell: UICollectionView!
  
  @IBOutlet weak var brandHeaders: UICollectionView!
  
  var arryPhone = [Phone] ()
  
  var arr:[Product]!
  var selectedType:String!
  var selectedBrand:String!
  var page:String!
  var arrSeleced:[Product]! = [Product]()
  var arrBrand:[String] = [String]()
  var selectedProdect:Product!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collcshinPhoneCell.delegate = self
    collcshinPhoneCell.dataSource = self
   
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    arrSeleced.removeAll()
    arr.forEach { Prodectse in
      if page == "Type" {
        if (Prodectse.type == selectedType) {
          arrSeleced.append(Product(id: Prodectse.id,
                                    image: Prodectse.image,
                                    info: Prodectse.info,
                                    price: Prodectse.price,
                                    brand: Prodectse.brand,
                                    type: Prodectse.type,
                                    Offers: Prodectse.Offers,
                                    images: Prodectse.images,
                                    isFavorite: Prodectse.isFavorite) )
          
        }
        
        
        if !arrBrand.contains(Prodectse.brand) {
          arrBrand.append(Prodectse.brand)
        }
      } else if page == "Brand" {
        if (Prodectse.brand == selectedBrand) {
          arrSeleced.append(Product(id: Prodectse.id,
                                    image: Prodectse.image,
                                    info: Prodectse.info,
                                    price: Prodectse.price,
                                    brand: Prodectse.brand,
                                    type: Prodectse.type,
                                    Offers: Prodectse.Offers,
                                    images: Prodectse.images,
                                    isFavorite: Prodectse.isFavorite))
        }
        if !arrBrand.contains(Prodectse.type) {
          arrBrand.append(Prodectse.type)
          
          
        }
      } else if page == "ALL" {
        if Prodectse.Offers {
          arrSeleced.append(Product(id: Prodectse.id,
                                    image: Prodectse.image,
                                    info: Prodectse.info,
                                    price: Prodectse.price,
                                    brand: Prodectse.brand,
                                    type: Prodectse.type,
                                    Offers: Prodectse.Offers,
                                    images: Prodectse.images,
                                    isFavorite: Prodectse.isFavorite) )
        }
        if !arrBrand.contains(Prodectse.brand) {
          arrBrand.append(Prodectse.brand)
        }
      }
    }
  }
  
  
  @IBAction func likeButtonPreased(_ sender: UIButton) {
    
    let index = sender.tag
    
    
    let db = Firestore.firestore()
    print("~~ \(arrSeleced[index].isFavorite)")
    if arrSeleced[index].isFavorite {
      sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
      db.collection("Prodects").document(arrSeleced[index].id).setData(["isFavorite":false],merge: true)
      
      if let index1 = arr.firstIndex(of: arrSeleced[index]) {
        arr[index1].isFavorite = false
        arrSeleced[index].isFavorite = false
      }
      db.collection("ProdectsFavorite").document(arrSeleced[index].id).delete()
    } else {
      if let index1 = arr.firstIndex(of: arrSeleced[index]) {
        arr[index1].isFavorite = true
        arrSeleced[index].isFavorite = true
        
      }
      //      arrSeleced[index].isFavorite = true
      sender.setImage(UIImage(systemName: "suit.heart.fill"),
                      for: .normal)
      db.collection("Prodects").document(arrSeleced[index].id).setData(["isFavorite":true], merge: true) { error in
        if error != nil {
          print("Error Edit : \(String(describing: error?.localizedDescription))")
        } else {
          db.collection("ProdectsFavorite").document(self.arrSeleced[index].id).setData(
            ["id":self.arrSeleced[index].id]) { error in
            if error != nil {
              print("Error add : \(String(describing: error?.localizedDescription))")
            } else {
              
            }
            
            
          }
        }
        
        
      }
      
    }
    
    
  }
  
  
  @IBAction func tollyForPay(_ sender: UIButton) {
    
    let index = sender.tag
    let db = Firestore.firestore()
    guard let auth = Auth.auth().currentUser else {
      print("~~~~~ Alert Please SignIn")
      return
    }
    
    let document = db.collection("Orders").document(auth.uid)
                                                    
      document.setData( ["orders": FieldValue.arrayUnion([arrSeleced[index].id])], merge: true)
      
    
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if collectionView == collcshinPhoneCell {
      return arrSeleced.count
    } else {
      return arrBrand.count
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    if collectionView == collcshinPhoneCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneDitels",
                                                    for: indexPath) as! PhoneDetailsCVCell
      
      let data = arrSeleced[indexPath.row]
      cell.likeButton.tag = indexPath.row
      cell.cartButton.tag = indexPath.row

      if data.isFavorite {
        cell.likeButton.setImage(UIImage(systemName: "suit.heart.fill"),
                                 for: .normal)
      } else {
        cell.likeButton.setImage(UIImage(systemName: "suit.heart"),
                                 for: .normal)
      }
      cell.Setupcell(photo: data.image,
                     price: data.price,
                     DisCrbsion:data.info )
      
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandHeader",
                                                    for: indexPath) as! BrandHeadersCVCell
      
      cell.name.text = arrBrand[indexPath.row]
      
      return cell
      
    }
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    if collectionView == collcshinPhoneCell {
    selectedProdect = arrSeleced[indexPath.row]
    }
    return true
  }
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    if let vc = segue.destination as? EndTransactionVC {
      vc.arri1 = selectedProdect
    }
  }
  
  
  
  
  
  
  
}
