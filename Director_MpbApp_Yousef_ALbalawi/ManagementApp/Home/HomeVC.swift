//
//  ViewController.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 27/05/1443 AH.
//

import UIKit
import Firebase
import SDWebImage

class HomeVC: UIViewController {
  
  
  
  @IBOutlet weak var collectionHome: UICollectionView!
  @IBOutlet weak var collectionBrand: UICollectionView!
  
  
  var dataCollection: CollectionReference!
  var arrProdects: [Product] = products
  var selectedBrand: String!
  var selectedPreodect: Product!
  var arrBrand: [String] = ["All"]
  var filterData: [Product]!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionHome.delegate = self
    collectionHome.dataSource = self
    collectionBrand.delegate = self
    collectionBrand.dataSource = self
    
    filterData = arrProdects
    let db = Firestore.firestore()
    dataCollection = db.collection("Prodects")
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getData()
  }
  
  
  @IBAction func deleatButton(_ sender: UIButton) {
    
    let index = sender.tag
    
    let ind = filterData.firstIndex(of: filterData[index])
    
    let db = Firestore.firestore()
    db
      .collection("Prodects").document(filterData[index].id).delete()
    
    filterData.remove(at: ind!)
    
    collectionHome.reloadData()
  }
  
  
  func getData() {
    
    arrProdects.removeAll()
    
    arrBrand.removeAll()
    
    arrBrand.append("All")
    dataCollection.addSnapshotListener { snapshot, error in
      if error != nil {
        print("Error: \(error?.localizedDescription ?? "")")
        
      } else {
        products.removeAll()
        
        
        for document in (snapshot?.documents)! {
          let data = document.data()
          let id = document.documentID
          products.append( Product(id:id,
                                   image: data["image"] as? String ?? "",
                                   info: data["info"] as! String,
                                   price: data["price"] as! Double,
                                   brand: data["brand"] as! String,
                                   type: data["type"] as! String,
                                   Offers: data["Offers"] as! Bool,
                                   images: data["images"] as? Array ?? [""] ,
                                   isFavorite: data["isFavorite"] as! Bool))}
        
        self.arrProdects = Product.getProducts()
        self.arrProdects.forEach { Prodectse in
          if !self.arrBrand.contains(Prodectse.brand) {
            self.arrBrand.append(Prodectse.brand)
          }
          self.filterData = self.arrProdects
        }
        self.collectionHome.reloadData()
        
        self.collectionBrand.reloadData()
      }
    }
  }
}


// MARK: - extensionCollectionView


extension HomeVC : UICollectionViewDelegate,
                   UICollectionViewDataSource {
  
  
  // MARK: - functionsCollectionView
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == collectionHome {
      let cell = collectionHome.dequeueReusableCell(withReuseIdentifier: "collall",
                                                    for: indexPath) as! CollectionViewCell
      
      if filterData.count != 0 {
        
        cell.img.sd_setImage(with: URL(string: filterData[indexPath.row].image),
                             placeholderImage: UIImage(named: ""))
        
        cell.infoLabel.text = filterData[indexPath.row].info
        
        cell.pricLabel.text = "\(filterData[indexPath.row].price) SR"
        
        cell.dletButton.tag = indexPath.row
        
      } else {
        
        cell.img.sd_setImage(with: URL(string: arrProdects[indexPath.row].image),
                             placeholderImage: UIImage(named: ""))
        
        cell.infoLabel.text = arrProdects[indexPath.row].info
        
        cell.pricLabel.text = "\(arrProdects[indexPath.row].price) SR"
      }
      return cell
      
    } else {
      
      let cll = collectionBrand.dequeueReusableCell(withReuseIdentifier: "brandColl", for: indexPath) as! BrandCollectionViewCell
      cll.brandLabel.text = arrBrand[0]
      return cll
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
    if collectionView == collectionHome {
      selectedPreodect = filterData[indexPath.row]
      
      var editVC = EditItme()
      
      if let arrController = self.tabBarController?.viewControllers {
        
        
        for vc in arrController {
          if vc is EditItme {
            editVC = vc as! EditItme
            editVC.prodect = filterData[indexPath.row]
            self.tabBarController?.selectedIndex = 1
          }
        }
      }
      
    } else {
      
      selectedBrand = arrBrand[indexPath.row]
      
      if selectedBrand != "All" {
        filterData = selectedBrand.isEmpty ? arrProdects : arrProdects.filter{ (item: Product) -> Bool in
          return item.brand.range(of: selectedBrand,
                                  options: .caseInsensitive,
                                  range: nil,
                                  locale: nil) != nil
        }
        
      } else {
        filterData = arrProdects
      }
      self.collectionHome.reloadData()
      print("~~ \(filterData.count)")
    }
    return true
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    if collectionHome == collectionBrand {
      return arrBrand.count
      
    } else {
      return filterData.count
    }
  }
}
