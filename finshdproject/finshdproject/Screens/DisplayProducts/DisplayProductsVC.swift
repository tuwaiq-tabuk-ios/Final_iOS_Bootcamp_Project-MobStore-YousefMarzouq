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
  
  
  // MARK: - Properties
  
  var selectedProdect:Product!
  var arrayAllPhone:[Product]!
  var selectedType:String!
  var selectedBrand:String!
  var page:String!
  var arraySeleced:[Product]! = [Product]()
  var arrayBrand:[String] = ["All"]
  var filterData:[Product]!
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var collcshinPhoneCell: UICollectionView!
  @IBOutlet weak var brandHeaders: UICollectionView!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collcshinPhoneCell.delegate = self
    collcshinPhoneCell.dataSource = self
    filterData = arraySeleced
    hideKeyboardWhenTappedAround()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    arraySeleced.removeAll()
    arrayAllPhone.forEach { Prodectse in
      if page == "Type" {
        if (Prodectse.type == selectedType) {
          arraySeleced.append(Product(id: Prodectse.id,
                                      image: Prodectse.image,
                                      info: Prodectse.info,
                                      price: Prodectse.price,
                                      brand: Prodectse.brand,
                                      type: Prodectse.type,
                                      Offers: Prodectse.Offers,
                                      images: Prodectse.images,
                                      isFavorite: Prodectse.isFavorite) )
        }
        if !arrayBrand.contains(Prodectse.brand) {
          arrayBrand.append(Prodectse.brand)
        }
        
        
      } else if page == "Brand" {
        if (Prodectse.brand == selectedBrand) {
          arraySeleced.append(Product(id: Prodectse.id,
                                      image: Prodectse.image,
                                      info: Prodectse.info,
                                      price: Prodectse.price,
                                      brand: Prodectse.brand,
                                      type: Prodectse.type,
                                      Offers: Prodectse.Offers,
                                      images: Prodectse.images,
                                      isFavorite: Prodectse.isFavorite))
        }
        if !arrayBrand.contains(Prodectse.type) {
          arrayBrand.append(Prodectse.type)
        }
        
        
      } else if page == "ALL" {
        if Prodectse.Offers {
          arraySeleced.append(Product(id: Prodectse.id,
                                      image: Prodectse.image,
                                      info: Prodectse.info,
                                      price: Prodectse.price,
                                      brand: Prodectse.brand,
                                      type: Prodectse.type,
                                      Offers: Prodectse.Offers,
                                      images: Prodectse.images,
                                      isFavorite: Prodectse.isFavorite) )
        }
        if !arrayBrand.contains(Prodectse.brand) {
          arrayBrand.append(Prodectse.brand)
        }
      }
    }
  }
  
  
  // MARK: - IBAction
  
  @IBAction func likeButtonPreased(_ sender: UIButton) {
    let index = sender.tag
    let db = Firestore.firestore()
    print("~~ \(arraySeleced[index].isFavorite)")
    if arraySeleced[index].isFavorite {
      sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
      db.collection("Prodects").document(arraySeleced[index].id).setData(["isFavorite":false],merge: true)
      if let index1 = arrayAllPhone.firstIndex(of: arraySeleced[index]) {
        arrayAllPhone[index1].isFavorite = false
        arraySeleced[index].isFavorite = false
      }
      db.collection("ProdectsFavorite").document(arraySeleced[index].id).delete()
    } else {
      if let index1 = arrayAllPhone.firstIndex(of: arraySeleced[index]) {
        arrayAllPhone[index1].isFavorite = true
        arraySeleced[index].isFavorite = true
      }
      sender.setImage(UIImage(systemName: "suit.heart.fill"),
                      for: .normal)
      db.collection("Prodects").document(arraySeleced[index].id).setData(["isFavorite":true], merge: true) { error in
        if error != nil {
          print("Error Edit : \(String(describing: error?.localizedDescription))")
        } else {
          db.collection("ProdectsFavorite").document(self.arraySeleced[index].id).setData(
            ["id":self.arraySeleced[index].id]) { error in
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
    sender.setImage(UIImage(systemName: "cart.fill"),
                    for: .normal)
    let index = sender.tag
    let db = Firestore.firestore()
    guard let auth = Auth.auth().currentUser else {
      return
    }
    let document = db.collection("Carts").document(auth.uid)
    document.setData( ["carts": FieldValue.arrayUnion([arraySeleced[index].id])], merge: true)
  }
  
  
  // MARK: - functions
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if collectionView == collcshinPhoneCell {
      return arraySeleced.count
    } else {
      return arrayBrand.count
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    if collectionView == collcshinPhoneCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneDitels",for: indexPath) as! PhoneDetailsCVCell
      let data = arraySeleced[indexPath.row]
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
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandHeader",for: indexPath) as! BrandHeadersCVCell
      cell.name.text = arrayBrand[indexPath.row]
      return cell
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    if collectionView == collcshinPhoneCell {
      selectedProdect = arraySeleced[indexPath.row]
    }
    return true
  }
  
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    if let vc = segue.destination as? EndTransactionVC {
      vc.arrayCarts = selectedProdect
    }
  }
}
