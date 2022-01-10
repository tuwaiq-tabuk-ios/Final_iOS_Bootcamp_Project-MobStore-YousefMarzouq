//
//  CartVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 17/05/1443 AH.


import UIKit
import Firebase
import Metal

class CartVC: UIViewController,
              UICollectionViewDelegate,
              UICollectionViewDataSource {
  
  
  var totlprice:Double = 0
  var arri2:[Cart]! = [Cart]()
  var DocumentReference: DocumentReference!
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
  }
  
  
  override func viewDidDisappear(_ animated: Bool) {
    totlprice = 0
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    getData()
  }
  
  func getData() {
    let db = Firestore.firestore()
    guard let auth = Auth.auth().currentUser else {
      print("~~~~~ Alert Please SignIn")
      return
    }
    arri2.removeAll()
    CollcshinCaSho.reloadData()
    totlprice = 0
    self.totllAount.text = "\(self.totlprice)"
    
    DocumentReference = db.collection("Carts").document(auth.uid)
    DocumentReference.getDocument { snapshot, error in
      if error != nil {
      } else {
        guard let data = snapshot!.data() else {
          return
        }
        for (key,values) in data {
          if key == "carts" {
            for value in values as! Array<Any> {
              db.collection("Prodects").document(value as! String).getDocument { documentSnapshot, error in
                if error != nil {
                } else {
                  let data = documentSnapshot!.data()!
                  let prodect = Product(id: value as! String,
                                        image: data["image"] as! String,
                                        info: data["info"] as! String,
                                        price: data["price"] as! Double,
                                        brand: data["brand"] as! String,
                                        type: data["type"] as! String,
                                        Offers: data["Offers"] as! Bool,
                                        images: data["images"] as! [String],
                                        isFavorite: data["isFavorite"] as! Bool)
                  let cart = Cart(product: prodect, count: 1)
                  self.arri2.append(cart)
                  self.totlprice +=  Double(cart.count) * Double(cart.product.price)
                  self.totllAount.text = "\(self.totlprice)"
                  self.CollcshinCaSho.reloadData()
                  
                   
                
                  
                }
              }
            }
          }
        }
      }
    }
  }
  
  @IBAction func rmoveItm(_ sender: UIButton) {
    let index = sender.tag
    let db = Firestore.firestore()
    let auth = Auth.auth().currentUser!
    let document = db.collection("Carts").document(auth.uid)
    document.setData( ["carts": FieldValue.arrayRemove([arri2[index].product.id])], merge: true)
    
    totlprice -= Double(arri2[index].count) * Double(arri2[index].product.price)
    totllAount.text = "\(totlprice)"
    arri2.remove(at: index)
    
    CollcshinCaSho.reloadData()
  }
  
  
  
  @IBAction func ContTobuy (_ sender: UIButton) {
   
    
  }
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? PurchaseInformationVC {
      vc.arri3 = arri2
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {

    return arri2.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaSho", for: indexPath) as! CartCollectionVCell
    cell.imgShoCr.sd_setImage(with: URL(string: arri2[indexPath.row].product.image), placeholderImage: UIImage(named: ""))
    cell.plasPressd.tag = indexPath.row
    cell.muensPressd.tag = indexPath.row
    cell.conttiCrSho.tag = indexPath.row
    cell.rmove.tag = indexPath.row
    cell.conttiCrSho.text = "\(arri2[indexPath.row].count)"
    cell.labelDitels.text = arri2[indexPath.row].product.info
    cell.labelPricShoCr.text = "\(arri2[indexPath.row].product.price)"
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  @IBAction func pluseButtonmPreased(_ sender: UIButton) {
    let cell = CollcshinCaSho!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CartCollectionVCell
    var conter = Int(cell.conttiCrSho.text!)
    conter! += 1
    cell.conttiCrSho.text = conter?.description
    totlprice += Double(cell.labelPricShoCr.text!)!
    totllAount.text = "\(totlprice)"
    arri2[sender.tag].count = conter!

  }
  
  
  @IBAction func minusButtonPreased(_ sender: UIButton) {
    let cell = CollcshinCaSho!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! CartCollectionVCell
    var conter = Int(cell.conttiCrSho.text!)
    if conter != 0 {
      conter! -= 1
      cell.conttiCrSho.text = conter?.description
      totlprice -= Double(cell.labelPricShoCr.text!)!
      totllAount.text = "\(totlprice)"
      arri2[sender.tag].count = conter!

    }
  }
}
