//
//  CartVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 17/05/1443 AH.


import UIKit
import Firebase
import Metal

class CartVC: UIViewController {
  
  // MARK: - Properties
  
  var totlprice: Double = 0
  var arrayShoppingcart: [Cart]! = [Cart]()
  var DocumentReference: CollectionReference!
  var selectBrand: String!
  
  
  // MARK: - IBOutlet
  
  
  @IBOutlet weak var Checkout: UIButton!
  @IBOutlet weak var totalsummation: UILabel!
  @IBOutlet weak var shoppingCart: UICollectionView!
  @IBOutlet weak var totalPraic: UILabel!
  @IBOutlet weak var heartpicture: UIImageView!
  
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shoppingCart.delegate = self
    shoppingCart.dataSource = self
  }
  
  
  override func viewDidDisappear(_ animated: Bool) {
    totlprice = 0
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
   
    getData()
    updateUI()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? PurchaseInformationVC {
      
      vc.carts = arrayShoppingcart
    }
  }
  
  
  // MARK: - IBAction
  
  @IBAction func ContTobuyPreased (_ sender: UIButton) {
    
  }
  
  @IBAction func rmoveItm(_ sender: UIButton) {
  
    let index = sender.tag
    let db = Firestore.firestore()
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    
    db
      .collection("users").document(userID).collection("Carts").document(arrayShoppingcart[index].product.id).delete()
    
    self.totlprice -= Double(self.arrayShoppingcart[index].count) * Double(self.arrayShoppingcart[index].product.price)
    self.totalPraic.text = "\(self.totlprice)"
    self.arrayShoppingcart.remove(at: index)
    self.shoppingCart.reloadData()
    
  }
  

  
  @IBAction func pluseButtonmPreased(_ sender: UIButton) {
   
    let cell = shoppingCart!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CartCollectionVCell
    var conter = Int(cell.conttiCrSho.text!)
    conter! += 1
    cell.conttiCrSho.text = conter?.description
    totlprice += Double(cell.labelPricShoCr.text!)!
    totalPraic.text = "\(totlprice)"
    arrayShoppingcart[sender.tag].count = conter!
  }
  
  
  @IBAction func minusButtonPreased(_ sender: UIButton) {
   
    let cell = shoppingCart!.cellForItem(at: IndexPath(row: sender.tag,
                                                       section: 0)) as! CartCollectionVCell
    var conter = Int(cell.conttiCrSho.text!)
    if conter != 0 {
      conter! -= 1
      cell.conttiCrSho.text = conter?.description
      totlprice -= Double(cell.labelPricShoCr.text!)!
      totalPraic.text = "\(totlprice)"
      arrayShoppingcart[sender.tag].count = conter!
    }
  }
  
  
  // MARK: - functions
  
  func updateUI() {
  
    if self.arrayShoppingcart.count == 0 {
      Checkout.isHidden = true
      totalsummation.isHidden = true
      shoppingCart.isHidden = true
      totalPraic.isHidden = true
      heartpicture.isHidden = false
  
    } else {
      Checkout.isHidden = false
      totalsummation.isHidden = false
      shoppingCart.isHidden = false
      totalPraic.isHidden = false
      heartpicture.isHidden = true
    }
  }
  
  func getData() {
  
    let db = Firestore.firestore()
    
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    
    
    db
      .collection("users").document(userID)
      .collection("Carts").addSnapshotListener { snapshot, error in
      if error != nil {
     
      } else {
        guard let document = snapshot?.documents else {
          return
        }
        self.totlprice = 0
        self.totalPraic.text = "\(self.totlprice)"
        self.arrayShoppingcart.removeAll()
        for snapsot in document {
          
          let data = snapsot.data()
          
          let prodect = Product(id: data["id"] as! String,
                                image: data["image"] as! String,
                                info: data["info"] as! String,
                                price: data["price"] as! Double,
                                brand: data["brand"] as! String,
                                type: data["type"] as! String,
                                Offers: data["Offers"] as! Bool,
                                images: data["images"] as! [String],
                                isFavorite: data["isFavorite"] as! Bool)
          let cart = Cart(product: prodect, count: 1)
          self.arrayShoppingcart.append(cart)
          self.totlprice +=  Double(cart.count) * Double(cart.product.price)
          self.totalPraic.text = "\(self.totlprice)"
        }
        self.shoppingCart.reloadData()
      }
    }
  }
}


// MARK: - extensionCollectionView


extension CartVC : UICollectionViewDelegate,
                   UICollectionViewDataSource {
  
  
  // MARK: - functions collectionView
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return arrayShoppingcart.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaSho", for: indexPath) as! CartCollectionVCell
    cell.imgShoCr.sd_setImage(with: URL(string: arrayShoppingcart[indexPath.row].product.image), placeholderImage: UIImage(named: ""))
    cell.plasPressd.tag = indexPath.row
    cell.muensPressd.tag = indexPath.row
    cell.conttiCrSho.tag = indexPath.row
    cell.rmove.tag = indexPath.row
    cell.conttiCrSho.text = "\(arrayShoppingcart[indexPath.row].count)"
    cell.labelDitels.text = arrayShoppingcart[indexPath.row].product.info
    cell.labelPricShoCr.text = "\(arrayShoppingcart[indexPath.row].product.price)"
    return cell
  }
}
