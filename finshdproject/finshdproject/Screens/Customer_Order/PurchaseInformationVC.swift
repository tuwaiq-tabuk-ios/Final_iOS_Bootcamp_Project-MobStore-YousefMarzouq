//
//  PurchaseInformationVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 23/05/1443 AH.
//

import UIKit
import SDWebImage
import Firebase


class PurchaseInformationVC: UIViewController ,
                             UITableViewDataSource,
                             UITableViewDelegate {
  
 
  // MARK: - Properties
  
  var arri3:[Cart]!
  var totlprice:Double = 0
  var billingAddress : [Double] = [Double]()
  var shippingAddress : [Double] = [Double]()
  
  
  let data1 : [purchase] = [
    purchase(labul: "Shipping Address",
             button: "Selection"),
    purchase(labul: "billing address",
             button: "Selection"),
    purchase(labul: "Payment method",
             button: "Selection"),
    //    purchase(labul: "Purchase information",
    //             button: "Selection"),
  ]
  
  
  // MARK: -IBOutlet
  
  @IBOutlet weak var tabelView: UITableView!
  @IBOutlet weak var cllColleViewPInfo: UICollectionView!
  @IBOutlet weak var subTotalLabel: UILabel!
  @IBOutlet weak var deliveryLabel: UILabel!
  @IBOutlet weak var taxLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  
  
  struct purchase {
    let labul : String
    let button : String
  }
  

  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    tabelView.delegate = self
    tabelView.dataSource = self
    cllColleViewPInfo.delegate = self
    cllColleViewPInfo.dataSource = self
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    for prodct in arri3 {
      totlprice +=  Double(prodct.count) * Double(prodct.product.price)
      subTotalLabel.text = "\(totlprice)"
      taxLabel.text = "\(totlprice * 0.15)"
      deliveryLabel.text = "20"
      let sum = Double(taxLabel.text!)! + Double(deliveryLabel.text!)!
      totalLabel.text = "\( sum + totlprice)"
    }
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(billingAddressReceive),
                                           name: Notification.Name("billingAddress"),
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(shippingAddressReceive),
                                           name: Notification.Name("shippingAddress"),
                                           object: nil)
  }
  
  
  @objc func billingAddressReceive(notification: Notification) {
    let data = notification.userInfo!
    let latitude = data["latitude"] as! Double
    let longitude = data["longitude"] as! Double
    billingAddress = [latitude,longitude]
  }
  
  
  @objc func shippingAddressReceive(notification: Notification) {
    let data = notification.userInfo!
    let latitude = data["latitude"] as! Double
    let longitude = data["longitude"] as! Double
    shippingAddress = [latitude,longitude]
  }
  
  
  // MARK: - IBAction
  
  @IBAction func comfirmButtonPreased(_ sender: UIButton) {
    
   
    var array = [[String:Any]]()
    for cart in arri3 {
      array.append(["count" : cart.count,
                    "id":cart.product.id])
    }
    
    let db = Firestore.firestore()
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    
    db.collection("users").document(userID).getDocument { document,
      error in
      guard error == nil else {
        return
      }
      let userdata = document!.data()!
      let customerName = "\(userdata["firstname"]!) \(userdata["lastname"]!)"
      db.collection("Orders").document("ordersCount").getDocument { document, error in
        guard error == nil else {
          return
        }
        let ordersCountData = document?.data()
        let orderNumber = ordersCountData?["count"] as! Int
        let sum = orderNumber + 1
        db.collection("Orders").document("ordersCount").setData(["count":sum], merge: true)
        db.collection("Orders").document(userID).setData(["\(sum)":[
          "id":userID,
          "customerName": customerName,
          "customerPhone":userdata["phone"] ?? "",
          "orderNumber":sum,
          "orderState":"Order sent",
          "billingAddress":self.billingAddress,
          "shippingAddress":self.shippingAddress,
          "totalAmount":self.totalLabel.text!,
          "orders":array,
        ]], merge: true) { error in
          guard error == nil else {
            return
          }
          for cart in self.arri3 {
            db.collection("users").document(userID).collection("Carts").document(cart.product.id).delete()
          }
          let alert =  UIAlertController (title: "Congrats", message: "We have received your order, thank you", preferredStyle: .alert)
          
          alert.addAction(UIAlertAction(title: "Thanks", style: .default,handler: { UIAlertAction in
            self.navigationController?.popViewController(animated: true)
          }))
          
          self.present(alert, animated: true)
          
        }
      }
    }
  }
  
  
  @IBAction func presdButton(_ sender: UIButton) {
    if sender.tag == 0 {
      let storyboard = UIStoryboard(name: "Main",
                                    bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddress")
      vc.modalPresentationStyle = .overFullScreen
      present(vc,
              animated: true)
    } else if sender.tag == 1{
      let storyboard = UIStoryboard(name: "Main",
                                    bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "billingAddress")
      vc.modalPresentationStyle = .overFullScreen
      present(vc,
              animated: true)
    } else if sender.tag == 2 {
      let storyboard = UIStoryboard(name: "Main",
                                    bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "PaymentMethod")
      vc.modalPresentationStyle = .overFullScreen
      present(vc,
              animated: true)
    }
    
    
  }
  
  
  @IBAction func rmoveBTPreased(_ sender: UIButton) {
    let index = sender.tag
    let db = Firestore.firestore()
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    db.collection("users").document(userID).collection("Carts").document(arri3[index].product.id).delete()

    totlprice -= Double(arri3[index].count) * Double(arri3[index].product.price)
    subTotalLabel.text = "\(totlprice)"
    taxLabel.text = "\(totlprice * 0.15)"
    deliveryLabel.text = "20"
    let sum = Double(taxLabel.text!)! + Double(deliveryLabel.text!)!
    totalLabel.text = "\( sum + totlprice)"
    arri3.remove(at: index)
    cllColleViewPInfo.reloadData()
  }
  
  
  @IBAction func addLikePreased(_ sender: UIButton) {
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int
  ) -> Int {
    return data1.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let sunde = data1[indexPath.row]
    let cll = tableView.dequeueReusableCell(withIdentifier: "TCll",for: indexPath) as! PurchaseInformationCellVCTablewCell
    cll .label.text = sunde.labul
    cll.button.tag = indexPath.row
    cll.button.setTitle(sunde.button,
                        for: .normal)
    cll.button.addTarget(self,
                         action: #selector(prssd(sender:)),
                         for: .touchUpInside)
    return cll
  }
  
  
  @objc
  func prssd (sender:UIButton){
    print("pressd inDix \(sender.tag)")
    
  }
}


// MARK: - extension

extension PurchaseInformationVC: UICollectionViewDelegate,
                                 UICollectionViewDataSource {
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arri3.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cll1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CCll", for: indexPath) as! PurchaseInformationCellVC
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    cll1.imageCellPurchase.sd_setImage(with: URL(string: arri3[indexPath.row].product.image),
                                       placeholderImage:animatedImage)
    cll1.infoPurchase.text =  arri3[indexPath.row].product.info
    cll1.praicPurchase.text = "\(arri3[indexPath.row].product.price) SR"
    return cll1
  }
  
  // MARK: - IBAction
  @IBAction func rmoveCollch(_ sender: UIButton) {
    
    /*
     let index = sendrt.tag
     Carts => Prodects
     auth.uid => ARRAY_NAME[index].id
     
     */
    
    //db.collection("Carts").document(auth.uid).delete()
  }
  
  
  @IBAction func addToLike(_ sender: UIButton) {
  }
}
