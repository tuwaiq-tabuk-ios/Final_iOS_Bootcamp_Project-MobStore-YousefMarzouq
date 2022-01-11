//
//  ViewController.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 27/05/1443 AH.
//

import UIKit
import Firebase
import SDWebImage
class ViewController: UIViewController ,
                      UICollectionViewDelegate,
                      UICollectionViewDataSource {
  
 
  
  @IBOutlet weak var collall: UICollectionView!
  @IBOutlet weak var brandColl: UICollectionView!
  
  
  var dataCollection:CollectionReference!
  var arrProdects:[Product] = products
  var selectedBrand:String!
  var selectedPreodect:Product!
  var arrBrand:[String] = ["All"]
  var filterData:[Product]!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collall.delegate = self
    collall.dataSource = self
    
    brandColl.delegate = self
    brandColl.dataSource = self
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
      db.collection("Prodects").document(filterData[index].id).delete()
    filterData.remove(at: ind!)
    collall.reloadData()

    }
  
  func getData() {
    arrProdects.removeAll()
    arrBrand.removeAll()
    arrBrand.append("All")
    dataCollection.getDocuments { snapshot, error in
      if error != nil {
        print("Error: \(error?.localizedDescription ?? "")")
      } else {
        products.removeAll()
        for document in (snapshot?.documents)! {
          let data = document.data()
          let id = document.documentID
          products.append( Product(id:id,
                                   image: data["image"] as! String,
                                   info: data["info"] as! String,
                                   price: data["price"] as! Double,
                                   brand: data["brand"] as! String,
                                   type: data["type"] as! String,
                                   Offers: data["Offers"] as! Bool,
                                   images: data["images"] as! Array,
                                   isFavorite: data["isFavorite"] as! Bool))
          
        }
        
        self.arrProdects = Product.getProducts()
        self.arrProdects.forEach { Prodectse in
          if !self.arrBrand.contains(Prodectse.brand) {
            self.arrBrand.append(Prodectse.brand)
          }
          self.filterData = self.arrProdects

        }
        self.collall.reloadData()
        self.brandColl.reloadData()
      }
    }
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if collectionView == brandColl {
      return arrBrand.count
    } else {
      return filterData.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == collall {
      let cll = collall.dequeueReusableCell(withReuseIdentifier: "collall",
                                            for: indexPath) as! CollectionViewCell
      if filterData.count != 0 {
        cll.img.sd_setImage(with: URL(string: filterData[indexPath.row].image),
                            placeholderImage: UIImage(named: ""))
        cll.btinfo.text = filterData[indexPath.row].info
        cll.btPric.text = "\(filterData[indexPath.row].price) SR"
        cll.dletBT.tag = indexPath.row
      } else {
      
      cll.img.sd_setImage(with: URL(string: arrProdects[indexPath.row].image),
                          placeholderImage: UIImage(named: ""))
      
      cll.btinfo.text = arrProdects[indexPath.row].info
      cll.btPric.text = "\(arrProdects[indexPath.row].price) SR"
      }
      return cll
    } else {
      let cll = brandColl.dequeueReusableCell(withReuseIdentifier: "brandColl", for: indexPath) as! BrandCollectionViewCell
      cll.brand.text = arrBrand[indexPath.row]
      return cll
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    if collectionView == collall {
    selectedPreodect = filterData[indexPath.row]
      var editVC = Paeg3VC()
      if let arrController = self.tabBarController?.viewControllers {
          for vc in arrController {
              if vc is Paeg3VC {
                editVC = vc as! Paeg3VC
                editVC.prodect = filterData[indexPath.row]
                print("~~ \(editVC.prodect)")
                  self.tabBarController?.selectedIndex = 1
              }
          }
      }
      
    } else {
      selectedBrand = arrBrand[indexPath.row]
      if selectedBrand != "All" {
      filterData = selectedBrand.isEmpty ? arrProdects : arrProdects.filter{ (item: Product) -> Bool in
        return item.brand.range(of: selectedBrand, options: .caseInsensitive, range: nil,locale: nil) != nil
      }
      } else {
        filterData = arrProdects
      }
      self.collall.reloadData()

      print("~~ \(filterData.count)")
    }
    return true
  }
  
}

