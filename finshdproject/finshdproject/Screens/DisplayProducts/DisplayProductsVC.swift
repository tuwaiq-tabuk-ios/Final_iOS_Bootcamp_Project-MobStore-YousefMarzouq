//
//  ViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 01/05/1443 AH.
//

import UIKit
import Firebase

class DisplayProductsVC: UIViewController {
  
  
  // MARK: - Properties
  
  var selectedProdect: Product!
  var arrayAllPhone: [Product]!
  var selectedType: String!
  var selectedBrand: String!
  var page: String!
  var arraySeleced: [Product]! = [Product]()
  var arrayBrand: [String] = ["All"]
  var filterData: [Product]!
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var collcshinPhoneCell: UICollectionView!
  @IBOutlet weak var brandHeaders: UICollectionView!
  
  
  // MARK: - View cohntroller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collcshinPhoneCell.delegate = self
    collcshinPhoneCell.dataSource = self
    
    brandHeaders.delegate = self
    brandHeaders.dataSource = self
    
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
    filterData = arraySeleced
  }
  
  
  
  // MARK: - IBAction
  
  @IBAction func likeButtonPreased(_ sender: UIButton) {
    
    let index = sender.tag
    let db = Firestore.firestore()
    
    guard let userID = Auth.auth().currentUser?.uid else {
      alert()
      return
    }
    
    if arraySeleced[index].isFavorite {
      sender.setImage(UIImage(systemName: "suit.heart"), for: .normal)
      
      if let index1 = arrayAllPhone.firstIndex(of: arraySeleced[index]) {
        arrayAllPhone[index1].isFavorite = false
        arraySeleced[index].isFavorite = false
      }
      
      db.collection("users").document(userID).collection("ProdectsFavorite").document(arraySeleced[index].id).delete()
      
    } else {
      
      if let index1 = arrayAllPhone.firstIndex(of: arraySeleced[index]) {
        arrayAllPhone[index1].isFavorite = true
        arraySeleced[index].isFavorite = true
      }
      sender.setImage(UIImage(systemName: "suit.heart.fill"),
                      for: .normal)
      
      db.collection("users").document(userID)
        .collection("ProdectsFavorite")
        .document(self.arraySeleced[index].id).setData(
          ["id": self.arraySeleced[index].id,
           "image": self.arraySeleced[index].image,
           "info": self.arraySeleced[index].info,
           "price": self.arraySeleced[index].price,
           "brand":self.arraySeleced[index].brand,
           "type":self.arraySeleced[index].type,
           "Offers":self.arraySeleced[index].Offers,
           "images":self.arraySeleced[index].images,
           "isFavorite":self.arraySeleced[index].isFavorite]) { error in
             
             if error != nil {
               print("Error add : \(String(describing: error?.localizedDescription))")
               
             } else {
             }
           }
    }
  }    // likeButtonPreased
  
  
  func alert() {
    
    let alert = UIAlertController(title: "alert",
                                  message: "Please Sign in Frist",
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Ok",
                                  style: .default,
                                  handler: { UIAlertAction in
      let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginVC
      loginVC.modalPresentationStyle = .overFullScreen
      self.present(loginVC,
                   animated: true,
                   completion: nil)
    }))
    present(alert, animated: true)
  }
  
  
  @IBAction func tollyForPayPreased(_ sender: UIButton) {
    
    sender.setImage(UIImage(systemName: "cart.fill"),
                    for: .normal)
    
    let index = sender.tag
    
    let db = Firestore.firestore()
    guard let userID = Auth.auth().currentUser?.uid else {
      alert()
      return
    }
    
    let document = db
      .collection("users").document(userID)
      .collection("Carts").document(arraySeleced[index].id)
    
    document.setData([
      "id":arraySeleced[index].id,
      "image":arraySeleced[index].image,
      "info":arraySeleced[index].info,
      "price":arraySeleced[index].price,
      "brand":arraySeleced[index].brand,
      "type":arraySeleced[index].type,
      "Offers":arraySeleced[index].Offers,
      "images":arraySeleced[index].images,
      "isFavorite":arraySeleced[index].isFavorite
    ], merge: true)
  }
}



// MARK: - extensionCollectionView

extension DisplayProductsVC: UICollectionViewDelegate,
                             UICollectionViewDataSource {
  
  
  // MARK: - functions collectionView
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == collcshinPhoneCell {
      return filterData.count
      
    } else {
      return arrayBrand.count
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    
    if collectionView == collcshinPhoneCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneDitels",for: indexPath) as! PhoneDetailsCVCell
      
      var data:Product!
      
      if filterData.count != 0 {
        data = filterData[indexPath.row]
        
      } else {
        data = arraySeleced[indexPath.row]
      }
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
      
    } else {
      selectedBrand = arrayBrand[indexPath.row]
      if selectedBrand != "All" {
        if page == "Brand" {
          filterData = selectedBrand.isEmpty ? arraySeleced : arraySeleced.filter{ (item: Product) -> Bool in
            return item.type.range(of: selectedBrand, options: .caseInsensitive, range: nil,
                                   locale: nil) != nil
          }
        } else {
          filterData = selectedBrand.isEmpty ? arraySeleced : arraySeleced.filter{ (item: Product) -> Bool in
            return item.brand.range(of: selectedBrand,
                                    options: .caseInsensitive,
                                    range: nil,
                                    locale: nil) != nil
          }
        }
        
      } else {
        filterData = arraySeleced
      }
      self.collcshinPhoneCell.reloadData()
    }
    return true
  }
  
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    if let vc = segue.destination as? EndTransactionVC {
      vc.product = selectedProdect
    }
  }
}

