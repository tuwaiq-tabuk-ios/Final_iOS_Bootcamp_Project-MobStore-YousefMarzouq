//
//  likeViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 19/05/1443 AH.
//

import UIKit
import Firebase
import SDWebImage

class LikeVC: UIViewController {
  
  
  // MARK: - Properties
  
  var productsLike: [Product]! = [Product]()
  var dataCollection: CollectionReference!
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var likeImg: UIImageView!
  @IBOutlet weak var likeCView: UICollectionView!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    likeCView.delegate = self
    likeCView.dataSource = self
    getData()
  }
  
  
  
  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    let index = sender.tag
    let db = Firestore.firestore()
    db.collection("Prodects").document(productsLike[index].id).setData(["isFavorite":false], merge: true)
    if let index1 = products.firstIndex(of: productsLike[index]) {
      products[index1].isFavorite = false
      productsLike[index].isFavorite = false
    }
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    db.collection("users").document(userID).collection("ProdectsFavorite").document(productsLike[index].id).delete()
    productsLike.remove(at: index)
    likeCView.reloadData()
  }
  
  
  // MARK: - functions
  
  func getData() {
    let db = Firestore.firestore()
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    db.collection("users").document(userID).collection("ProdectsFavorite").addSnapshotListener { snapsot, error in
      if error != nil {
      } else {
        self.productsLike.removeAll()
        for document in snapsot!.documents {
          let data = document.data()
          let id = document.documentID
          let prodects = Product(id: id,
                                 image: data["image"] as! String,
                                 info: data["info"] as! String,
                                 price: data["price"] as! Double,
                                 brand: data["brand"] as! String,
                                 type: data["type"] as! String,
                                 Offers: data["Offers"] as! Bool,
                                 images: data["images"] as! Array,
                                 isFavorite: data["isFavorite"] as! Bool)
          if !self.productsLike.contains(where: { Prodects in
            if Prodects.id == prodects.id {
              return true
            } else {
              return false
            }
          }) {
            self.productsLike.append(prodects)
            self.likeCView.reloadData()
          }
        }
      }
    }
  }
  
  
  func updateUI() {
    if self.productsLike.count == 0 {
      self.likeImg.isHidden = false
      self.likeCView.isHidden = true
    } else {
      self.likeImg.isHidden = true
      self.likeCView.isHidden = false
    }
  }
}


// MARK: - extensionCollectionView

extension LikeVC: UICollectionViewDataSource ,
                  UICollectionViewDelegate,
                  UICollectionViewDelegateFlowLayout {
  
  
  // MARK: - functionsCollectionView
  
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    updateUI()
    return productsLike.count
  }
  
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = likeCView.dequeueReusableCell(withReuseIdentifier: "likeSho",
                                             for: indexPath) as! likeCollectionVCell
    let array = productsLike[indexPath.row]
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    cell.imgFibrtcll.sd_setImage(with: URL(string: array.image),
                                 placeholderImage:animatedImage)
    cell.ditelsFibrt.text = array.info
    cell.pricFibrt.text = "\(array.price)"
    cell.deleteButton.tag = indexPath.row
    return cell
  }
}


