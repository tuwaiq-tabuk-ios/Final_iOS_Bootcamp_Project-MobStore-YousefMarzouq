//
//  Page5VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 29/05/1443 AH.
//

import UIKit
import Firebase

class CustomerOrderS: UIViewController {
  
  
  // MARK: - Properties
  
  var DocumentReference: CollectionReference!
  var customerOrderS : [Order] = [Order]()
  var selectedOrder:Order!
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var collectionCustomerOrderS: UICollectionView!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionCustomerOrderS.delegate = self
    collectionCustomerOrderS.dataSource = self
    getData()
  }
  
  
  // MARK: - functions

  
  
  func getData() {
    let db = Firestore.firestore()
    DocumentReference = db.collection("Orders")
    DocumentReference.addSnapshotListener { snapshot, error in
      if error != nil {
      } else {
        self.customerOrderS.removeAll()
        self.collectionCustomerOrderS.reloadData()
        
        for document in snapshot!.documents {
          let data = document.data()
          if document.documentID != "ordersCount" {
            for (_, values) in data {
              let data = values as! [String:Any]
              var carts: [Cart] = [Cart]()
              for product in data["orders"] as! [[String:Any]] {
                var cont :Int!
                var id :String!
                for (key,value) in product  {
                  if key == "id" {
                    id = value as? String
                  }else{
                    cont = value as? Int
                  }
                }
                db.collection("Prodects").document(id).addSnapshotListener { snapshot, error in
                  guard error == nil else {
                    return
                  }
                  let data = snapshot!.data()!
                  let id = snapshot!.documentID
                  let product = Product(id: id,
                                        image: data["image"] as! String,
                                        info: data["info"] as! String,
                                        price: data["price"] as! Double,
                                        brand: data["brand"] as! String,
                                        type: data["type"] as! String,
                                        Offers: data["Offers"] as! Bool,
                                        images: data["images"] as! Array<String>,
                                        isFavorite: data["isFavorite"] as! Bool)
                  let cart = Cart(product: product, counts: cont)
                  carts.append(cart)
                }
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                let products = Order(id:data["id"] as!String,
                                     customerName:data["customerName"] as!String ,
                                     customerPhone:data[ "customerPhone"]as!String,
                                     orderNumber:data["orderNumber"]as! Int ,
                                     orderState:data["orderState"]as!String,
                                     billingAddress:data["billingAddress"] as! Array ,
                                     shippingAddress: data["shippingAddress"] as! Array,
                                     totalAmount:data["totalAmount"] as! String,
                                     orders:carts)
                self.customerOrderS.append(products)
                print(self.customerOrderS[0].orders[0].product.info)
                self.collectionCustomerOrderS.reloadData()
              }
            }
          }
        }
      }
    }
  }
}


// MARK: - extensionCollectionView


extension CustomerOrderS : UICollectionViewDelegate,
                           UICollectionViewDataSource {
  
  
  // MARK: - functionscollectionView
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return customerOrderS.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cll = collectionCustomerOrderS.dequeueReusableCell(withReuseIdentifier: "collectionPage5", for: indexPath) as! Page5CollectionViewCell
    cll.imgItm.sd_setImage(with: URL(string: customerOrderS[indexPath.row].orders[0].product.image))
    
    cll.loucitonCoustmer.text = "\(customerOrderS[indexPath.row].billingAddress[0]) \(customerOrderS[indexPath.row].billingAddress[1])"
    
    
    
    cll.namburPhone.text = customerOrderS [indexPath.row].customerPhone
    cll.nameCastmer.text = customerOrderS[indexPath.row].customerName
    cll.nameOFitme.text =  customerOrderS[indexPath.row].orders[0].product.info
    cll.praicOFitme.text = "\(customerOrderS[indexPath.row].totalAmount) SR"
    return cll
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    selectedOrder = customerOrderS[indexPath.row]
    return true
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showOrders":
      
      if let vc = segue.destination as? OrderVC {
        vc.order = selectedOrder
      }
    default:
      print("else")
    }
  }
}
