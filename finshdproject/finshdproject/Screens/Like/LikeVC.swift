//
//  likeViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 19/05/1443 AH.
//

import UIKit
import Firebase
import SDWebImage

class LikeVC: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout {
  
  
  @IBOutlet weak var likeImg: UIImageView!
  
  //  var SDAnimatedImageView = SDAnimatedImageView()
  
  var products: [Product]! = [Product]()
  var dataCollection: CollectionReference!
  
  @IBOutlet weak var likeCView: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    likeCView.delegate = self
    likeCView.dataSource = self
    
    
    if products.count == 1 {
      likeCView.isHidden = true
    } else {
      likeImg.isHidden = true
    }
    let db = Firestore.firestore()
    dataCollection = db.collection("ProdectsFavorite")
    
    //getData()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.likeCView.reloadData()
    getData()
  }
  
  
  func getData() {
    let db = Firestore.firestore()
    
    dataCollection.getDocuments { snapsot, error in
            if error != nil {
      
            } else {
      for document in snapsot!.documents {
        let data = document.data()
        let dataCollection2 = db.collection("Prodects").document(data["id"] as! String)
        
        dataCollection2.getDocument { snapshotData, error in
          if error != nil {
            print("~~ error: \(String(describing: error?.localizedDescription))")
          } else {
            let data = snapshotData!.data()!
            let id = snapshotData?.documentID
            let prodects = Product(id: id!,
                                   image: data["image"] as! String,
                                   info: data["info"] as! String,
                                   price: data["price"] as! Double,
                                   brand: data["brand"] as! String,
                                   type: data["type"] as! String,
                                   Offers: data["Offers"] as! Bool,
                                   images: data["images"] as! Array,
                                   isFavorite: data["isFavorite"] as! Bool)
            if !self.products.contains(where: { Prodects in
              if Prodects.id == prodects.id {
                return true
              } else {
                return false
              }
              
            }) {
              self.products.append(prodects)
              self.likeCView.reloadData()
            }
          }
        }
      }
    }
    
//    self.likeCView.reloadData()
  }
  
  }
  
}



extension LikeVC: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return products.count
  }
  
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = likeCView.dequeueReusableCell(withReuseIdentifier: "likeSho", for: indexPath) as! likeCollectionVCell
    
    
    let array = products[indexPath.row]
    let imageView = SDAnimatedImageView()
    let animatedImage = SDAnimatedImage(named: "Loader1")
    imageView.image = animatedImage
    
    cell.imgFibrtcll.sd_setImage(with: URL(string: array.image), placeholderImage:imageView.image)
    
    
    
    cell.ditelsFibrt.text = array.info
    cell.pricFibrt.text = "\(array.price)"
    
    
    return cell
    
  }
  
}

