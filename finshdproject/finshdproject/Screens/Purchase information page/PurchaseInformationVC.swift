//
//  PurchaseInformationVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 23/05/1443 AH.
//

import UIKit
import Firebase
import SDWebImage


class PurchaseInformationVC: UIViewController {
  
  struct Purchase {
    let label : String
    let button : String
  }
  
  
  // MARK: - Properties
  
  var carts: [Cart]!
  var totalPrice: Double = 0
  var billingAddresses : [Double] = [Double]()
  var shippingAddresses : [Double] = [Double]()
  
  
  let customerInformation : [Purchase] = [
    Purchase(label: "Shipping Address",
             button: "Selection"),
    Purchase(label: "billing address",
             button: "Selection"),
    Purchase(label: "Payment method",
             button: "Selection"),
    //    purchase(labul: "Purchase information",
    //             button: "Selection"),
  ]
  
  
  
  // MARK: -IBOutlets
  
  @IBOutlet weak var tabelView: UITableView!
  @IBOutlet weak var cllColleViewPInfo: UICollectionView!
  @IBOutlet weak var subTotalLabel: UILabel!
  @IBOutlet weak var deliveryLabel: UILabel!
  @IBOutlet weak var taxLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  
  
  
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
    
    for cart in carts {
      totalPrice +=  Double(cart.count) * cart.product.price
      subTotalLabel.text = "\(totalPrice)"
      taxLabel.text = "\(totalPrice * 0.15)"
      deliveryLabel.text = "20"
      
      let sum = Double(taxLabel.text!)! + Double(deliveryLabel.text!)!
      totalLabel.text = "\( sum + totalPrice)"
    }
    
    NotificationCenter
      .default
      .addObserver(self,
                   selector: #selector(billingAddressReceive),
                   name: Notification.Name("billingAddress"),
                   object: nil)
    
    NotificationCenter
      .default
      .addObserver(self,
                   selector: #selector(shippingAddressReceive),
                   name: Notification.Name("shippingAddress"),
                   object: nil)
  }
  
  
  @objc func billingAddressReceive(notification: Notification) {
    
    let data = notification.userInfo!
    
    let latitude = data["latitude"] as! Double
    
    let longitude = data["longitude"] as! Double
    
    billingAddresses = [latitude, longitude]
  }
  
  
  @objc func shippingAddressReceive(notification: Notification) {
    
    let data = notification.userInfo!
    
    let latitude = data["latitude"] as! Double
    
    let longitude = data["longitude"] as! Double
    
    shippingAddresses = [latitude, longitude]
  }
  
  
  
  // MARK: - IBAction
  
  @IBAction func comfirmButtonPreased(_ sender: UIButton) {
    
    if billingAddresses.count == 0 {
      let alert =  UIAlertController (title: "billingAddress",
                                      message: "Please select a location", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Open",
                                    style: .default,
                                    handler: { UIAlertAction in
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "billingAddress")
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc,
                     animated: true)      }))
      
      self.present(alert, animated: true)
      
      return
      
    }
    
    if shippingAddresses.count == 0 {
      
      let alert =  UIAlertController (title: "shippingAddress",
                                      message: "Please select a location",
                                      preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "Open",
                                    style: .default,
                                    handler: { UIAlertAction in
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddress")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,
                     animated: true)
      }))
      
      self.present(alert, animated: true)
      return
    }
    
    var array = [[String:Any]]()
    
    for cart in carts {
      array.append(["count" : cart.count,
                    "id":cart.product.id])
    }
    
    let db = Firestore.firestore()
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    
    db
      .collection("users")
      .document(userID)
      .getDocument { document, error in
        guard error == nil else {
          return
        }
        
        let userdata = document!.data()!
        
        let customerName = "\(userdata["firstname"]!) \(userdata["lastname"]!)"
        db
          .collection("Orders")
          .document("ordersCount")
          .getDocument { document, error in
            guard error == nil else {
              return
            }
            
            let ordersCountData = document?.data()
            
            let orderNumber = ordersCountData?["count"] as! Int
            
            let sum = orderNumber + 1
            
            db
              .collection("Orders")
              .document("ordersCount")
              .setData(["count":sum], merge: true)
            
            db.collection("Orders")
              .document(userID)
              .setData(["\(sum)":[
                "id":userID,
                "customerName": customerName,
                "customerPhone":userdata["phone"] ?? "",
                "orderNumber":sum,
                "orderState":"Order sent",
                "billingAddress":self.billingAddresses,
                "shippingAddress":self.shippingAddresses,
                "totalAmount":self.totalLabel.text!,
                "orders":array,
              ]], merge: true) { error in
                guard error == nil else {
                  return
                }
                
                for cart in self.carts {
                  
                  db
                    .collection("users")
                    .document(userID)
                    .collection("Carts")
                    .document(cart.product.id)
                    .delete()
                }
                
                let alert =  UIAlertController (title: "Congrats",
                                                message: "We have received your order, thank you",
                                                preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Thanks",
                                              style: .default,
                                              handler: { UIAlertAction in
                  self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert,
                             animated: true)
              }
          }
      } // db.collection("users").document(userID).getDocument { document, error in
  } // comfirmButtonPreased(_ sender: UIButton)
  
  
  @IBAction func presdButton(_ sender: UIButton) {
    
    if sender.tag == 0 {
      
      let storyboard = UIStoryboard(name: "Main",
                                    bundle: nil)
      
      let vc = storyboard.instantiateViewController(withIdentifier: K.Storyboard.shippingVCIdentifier)
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
    db
      .collection("users").document(userID)
      .collection("Carts").document(carts[index].product.id).delete()
    
    totalPrice -= Double(carts[index].count) * Double(carts[index].product.price)
    
    subTotalLabel.text = "\(totalPrice)"
    
    taxLabel.text = "\(totalPrice * 0.15)"
    
    deliveryLabel.text = "20"
    
    let sum = Double(taxLabel.text!)! + Double(deliveryLabel.text!)!
    
    totalLabel.text = "\( sum + totalPrice)"
    
    carts.remove(at: index)
    
    cllColleViewPInfo.reloadData()
  }
  
  
  @IBAction func addLikePreased(_ sender: UIButton) {
  }
  
  
  @objc
  func prssd (sender:UIButton){
    
    print("pressd inDix \(sender.tag)")
  }
}



// MARK: - extensionCollectionView

extension PurchaseInformationVC: UICollectionViewDelegate,
                                 UICollectionViewDataSource {
  
  
  // MARK: - functions collectionView
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    return carts.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCll", for: indexPath) as! PurchaseInformationCellVC
    
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    
    cell.imageCellPurchase.sd_setImage(with: URL(string: carts[indexPath.row].product.image),
                                       placeholderImage:animatedImage)
    
    cell.infoPurchase.text =  carts[indexPath.row].product.info
    
    cell.praicPurchase.text = "\(carts[indexPath.row].product.price) SR"
    return cell
  }
  
  
  
  // MARK: - IBAction
  @IBAction func rmoveCollch(_ sender: UIButton) {
    
  }
  
  
  @IBAction func addToLike(_ sender: UIButton) {
  }
}



// MARK: - extensionTableView


extension PurchaseInformationVC: UITableViewDataSource,
                                 UITableViewDelegate {
  
  
  // MARK: - functionsTableView
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int
  ) -> Int {
    
    return customerInformation.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    
    let sunde = customerInformation[indexPath.row]
    
    let cellTable = tableView.dequeueReusableCell(withIdentifier: "TCll",for: indexPath) as! PurchaseInformationCellVCTablewCell
    
    cellTable .label.text = sunde.label
    
    cellTable.button.tag = indexPath.row
    
    cellTable.button.setTitle(sunde.button,
                              for: .normal)
   
    cellTable.button.addTarget(self,
                               action: #selector(prssd(sender:)),
                               for: .touchUpInside)
    return cellTable
  }
}
