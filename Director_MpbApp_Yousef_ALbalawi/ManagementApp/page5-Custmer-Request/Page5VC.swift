//
//  Page5VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 29/05/1443 AH.
//

import UIKit
import Firebase

class Page5VC: UIViewController,
               UICollectionViewDelegate,
               UICollectionViewDataSource {
  
  
  
  var DocumentReference: CollectionReference!
  var arri4 : [Order] = [Order]()
  var arrProdects:[Product] = products

  
  
  
  
  @IBOutlet weak var collectionPage5: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionPage5.delegate = self
    collectionPage5.dataSource = self
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    getData()
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return arri4.count
    
    
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cll = collectionPage5.dequeueReusableCell(withReuseIdentifier: "collectionPage5", for: indexPath) as! Page5CollectionViewCell
    
    cll.imgItm5.sd_setImage(with: URL(string: arri4[indexPath.row].orders[0].product.image))
    
    
    cll.loucitonCoustmer.text = "\(arri4[indexPath.row].billingAddress[0]) \(arri4[indexPath.row].billingAddress[1])"
    
    
    cll.namburPhone.text = arri4 [indexPath.row].customerPhone
    
    cll.nameOFitme.text =  arri4[indexPath.row].orders[indexPath.row].product.info
    
    cll.praicOFitme.text = "\(arri4[indexPath.row].orders[indexPath.row].product.price) SR"
   
    
    cll.nameCastmer.text = arri4[indexPath.row].customerName
    return cll
  }
  
  
  
  
  func getData() {
    let db = Firestore.firestore()
    arri4.removeAll()
    collectionPage5.reloadData()
   
    DocumentReference = db.collection("Orders")
    DocumentReference.getDocuments { snapshot, error in
      if error != nil {
      } else {
        
        for document in snapshot!.documents {
          let data = document.data()
          if document.documentID != "ordersCount" {
            
            for (key, values) in data {
              let data = values as! [String:Any]
              var carts: [Cart] = [Cart]()
              for product in data["orders"] as! [[String:Any]] {
                var cont :Int!
                var id :String!
                for (key,value) in product  {
                  if key == "id" {
                    id = value as! String
                  }else{
                    cont = value as! Int
                  }
                }
                db.collection("Prodects").document(id).getDocument { snapshot, error in
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
                  
                  let cart = Cart(product: product, count: cont)
                  carts.append(cart)
                }
              }
              
              DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                let products = Order(customerName:data["customerName"] as!String ,
                                     customerPhone:data[ "customerPhone"]as!String,
                                     orderNumber:data["orderNumber"]as! Int ,
                                     orderState:data["orderState"]as!String,
                                     billingAddress:data["billingAddress"] as! Array ,
                                     shippingAddress: data["shippingAddress"] as! Array,
                                     totalAmount:data["totalAmount"] as! String,
                                     orders:carts)
                
                self.arri4.append(products)
                print(self.arri4[0].orders[0].product.info)
                self.collectionPage5.reloadData()
              }
            
            }
            
            
          }
        }
      }
    }
  }
  
  
}


