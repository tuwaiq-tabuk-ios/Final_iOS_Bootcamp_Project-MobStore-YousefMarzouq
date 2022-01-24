//
//  HomeVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 02/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage



class HomeVC: UIViewController {
  
  
  // MARK: - Properties
  
  var homeProdects: [Product] = products
  var homeProdectsInOffer: [Product] = []
  var selectedBrand: String!
  var selectedPreodect: Product!
  var timer: Timer?
  var currentCellIndix = 0
  var fbCollection: CollectionReference!
  
  var arrayProducPhotos = [UIImage(named: "iPhone12ProMax_Header"),
                           UIImage(named: "Xiaomi_Header"),]
  
  var brandOuter: [Brand] = [
    Brand(image: UIImage(named: "Apple_Brand")!,
          name: "Apple"),
    Brand(image: UIImage(named: "Huawei_Brand")!,
          name: "Huawei"),
    Brand(image: UIImage(named: "Infinix_Brand")!,
          name: "Infinix"),
    Brand(image: UIImage(named: "Honor_Brand")!,
          name: "Honor"),
    Brand(image: UIImage(named: "Nokia_Brand")!,
          name: "Nokia"),
    Brand(image: UIImage(named: "Itel_Brand")!,
          name: "Itel"),
    Brand(image: UIImage(named: "Lenovo_Brand")!,
          name: "Lenovo"),
    Brand(image: UIImage(named: "Oppo_Brand")!,
          name: "Oppo"),
    Brand(image: UIImage(named: "Samsung_Brand")!,
          name: "Samsung"),
    Brand(image: UIImage(named: "Vivo_Brand")!,
          name: "Vivo"),
    Brand(image: UIImage(named: "Xiaomi_Brand")!,
          name: "Xiaomi"),]
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var brandCollectionView: UICollectionView!
  @IBOutlet weak var brandCollectionView2: UICollectionView!
  
  
  // MARK: - View cohntroller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    let db = Firestore.firestore()
    fbCollection = db.collection("Prodects")
    
    getData()
    
    startTimer()
  }
  
  
  
  // MARK: - functions
  
  func getData() {
    fbCollection.addSnapshotListener { snapshot, error in
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
                                   images: data["images"] as? Array ?? [""],
                                   isFavorite: data["isFavorite"] as! Bool))
        }
        self.homeProdects = Product.getProducts()
        self.homeProdectsInOffer.removeAll()
        self.homeProdects.forEach { Prodectse in
          if (Prodectse.Offers) {
            self.homeProdectsInOffer.append(Product(id: Prodectse.id,
                                                    image: Prodectse.image,
                                                    info: Prodectse.info,
                                                    price: Prodectse.price,
                                                    brand: Prodectse.brand,
                                                    type: Prodectse.type,
                                                    Offers: Prodectse.Offers,
                                                    images: Prodectse.images,
                                                    isFavorite: Prodectse.isFavorite))
          }
        }
        self.brandCollectionView2.reloadData()
      }
    }
  }
  
  
  func startTimer () {
    
    timer = Timer.scheduledTimer(timeInterval: 2.5,
                                 target: self,
                                 selector: #selector(moveToNextIndix),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  
  @objc func moveToNextIndix () {
    
    if currentCellIndix < arrayProducPhotos.count - 1 {
      currentCellIndix += 1
      
    }else {
      currentCellIndix = 0
    }
    collectionView.scrollToItem(at: IndexPath(item: currentCellIndix,
                                              section: 0), at: .centeredHorizontally,
                                animated: true)  }
  
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    
    switch segue.identifier {
      
    case "showPhone":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = homeProdects
        vc.selectedType = "Phone"
        vc.page = "Type"
        vc.selectedBrand = ""
        
      }
    case "showTablet":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = homeProdects
        vc.selectedType = "Tablet"
        vc.page = "Type"
        vc.selectedBrand = ""
      }
      
    case "showAccessories":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = homeProdects
        vc.selectedType = "Accessories"
        vc.page = "Type"
        vc.selectedBrand = ""
      }
      
    case "showCardGame":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = homeProdects
        vc.selectedType = "CardGame"
        vc.page = "Type"
        vc.selectedBrand = ""
      }
      
    case "showProdect1":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = homeProdects
        vc.selectedType = ""
        vc.page = "Brand"
        vc.selectedBrand = selectedBrand
      }
      
    case "arrProducPhotos2":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = homeProdectsInOffer
        vc.selectedType = ""
        vc.page = "ALL"
        vc.selectedBrand = ""
      }
      
    case "showDeatil2":
      if let vc = segue.destination as? EndTransactionVC {
        vc.product = selectedPreodect
      }
      
    default:
      print("default")
    }
  }
}


// MARK: - extensionCollectionView


extension HomeVC: UICollectionViewDelegate,
                  UICollectionViewDataSource,
                  UICollectionViewDelegateFlowLayout {
  
  
  // MARK: - functions collectionView
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    
    if (collectionView == brandCollectionView) {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell",
                                                    for: indexPath ) as! BrandShowAllCVCell
      
      cell.brandImagee.image = brandOuter[indexPath.row].image
      return cell
      
    } else if (collectionView == brandCollectionView2) {
     
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prodectCell",for: indexPath ) as! ProductsCVCell
      
      cell.Setupcell(photo: homeProdectsInOffer[indexPath.row].image,
                     price: homeProdectsInOffer[indexPath.row].price,
                     DisCrbsion: homeProdectsInOffer[indexPath.row].info)
      return cell
      
    } else {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell",
                                                    for: indexPath ) as! HomeVCCell
      cell.img.image = arrayProducPhotos[indexPath.row]
      return cell
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    if (collectionView == brandCollectionView){
      return 30
    
    } else if (collectionView == brandCollectionView2){
      return 20
   
    } else {
      return 0
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    if (collectionView == brandCollectionView){
      return 30
    
    } else if (collectionView == brandCollectionView2){
      return 20
    
    } else {
      return 0
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int
  ) -> Int {
    if (collectionView == brandCollectionView) {
      return brandOuter.count
      
    }else  if (collectionView == brandCollectionView2) {
      return homeProdectsInOffer.count
      
    } else {
      return arrayProducPhotos.count
    }
  }
  
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    
    if (collectionView == brandCollectionView) {
      if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
        return layout.itemSize
        
      } else {
        return .zero
      }
    } else if (collectionView == brandCollectionView2) {
      return CGSize(width: collectionView.frame.width * 0.3,
                    height: collectionView.frame.height * 1)
    } else {
      return CGSize(width: collectionView.frame.width,
                    height: collectionView.frame.height)
    }
  }
  
  
  func configureSize(numOfHorizontsalCells:CGFloat,
                     marginBetweenCells:CGFloat) {
    
    print("\n \(#function)")
    
    let layout = UICollectionViewFlowLayout()
    let totalMarginBetweenCells:CGFloat = marginBetweenCells * (numOfHorizontsalCells - 1)
    let marginPerCell: CGFloat = totalMarginBetweenCells / numOfHorizontsalCells
    let frameWidth = brandCollectionView.frame.width
    let cellWidth = frameWidth / numOfHorizontsalCells - marginPerCell
    let cellHight = frameWidth / numOfHorizontsalCells
    
    layout.minimumLineSpacing = marginPerCell
    layout.minimumInteritemSpacing = marginPerCell
    layout.estimatedItemSize = .zero
    layout.itemSize = CGSize(width: cellWidth, height: cellHight)
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
    if (collectionView == brandCollectionView){
      selectedBrand = brandOuter[indexPath.row].name
      
    } else if (collectionView == brandCollectionView2) {
      selectedPreodect = homeProdectsInOffer[indexPath.row]
    }
    return true
  }
}

