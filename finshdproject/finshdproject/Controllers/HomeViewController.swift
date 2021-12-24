//
//  HomeViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 02/05/1443 AH.
//

import UIKit

struct Brand {
  let image:UIImage
  let name:String
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,
                          UICollectionViewDelegateFlowLayout {
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var brandCollectionView: UICollectionView!
  
  @IBOutlet weak var brandCollectionView2: UICollectionView!
  
  
  var arrProducPhotos = [UIImage(named: "promoipel10"),
                         UIImage(named: "Xiaomi-Promotion"),
                        ]
  
  
  
  var arrProducPhotos1: [Brand] = [
    Brand(image: UIImage(named: "Apple_brand")!, name: "Apple"),
    Brand(image: UIImage(named: "Huawei_Brand")!, name: "Huawei"),
    Brand(image: UIImage(named: "infinix")!, name: "Infinix"),
    Brand(image: UIImage(named: "Honor-Logo")!, name: "Honor"),
    Brand(image: UIImage(named: "nokia")!, name: "Nokia"),
    Brand(image: UIImage(named: "Itel_Brand")!, name: "Itel"),
    Brand(image: UIImage(named: "oppo")!, name: "Oppo"),
    Brand(image: UIImage(named: "Samsung_brand")!, name: "Samsung"),
    Brand(image: UIImage(named: "Vivo_Brand")!, name: "Vivo"),
    Brand(image: UIImage(named: "xiaomi_brand")!, name: "Xiaomi"),
  ]
    
    
  
  
  
  
  var arrProdects:[Prodects] = Prodects.getarray()
  var selectedType:String!
  
  var arrOffers:[Prodects] = []
  var selectedBrand:String!
  var selectedPreodect:Prodects!

  
  var timer:Timer?
  var crandcellIndix = 0
  
  var arrBrand:[String] = [String]()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    
    
    startTimer()
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    arrOffers.removeAll()
    arrProdects.forEach { Prodectse in
//      if (Prodectse.brand == selectBrand && Prodectse.type == "Accessories") {
      if (Prodectse.Offers) {
        arrOffers.append(Prodects(image: Prodectse.image, info: Prodectse.info, price: Prodectse.price, brand: Prodectse.brand, type: Prodectse.type, Offers: Prodectse.Offers, images: Prodectse.images, isFavorite: false) )
      }
      
    }
  }
  
  
  
  
  func startTimer () {
    
    timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndix), userInfo: nil, repeats: true)
  }
  
  @objc func moveToNextIndix () {
    if crandcellIndix < arrProducPhotos.count - 1 {
      crandcellIndix += 1
    }else {
      crandcellIndix = 0
    }
    collectionView.scrollToItem(at: IndexPath(item: crandcellIndix, section: 0), at: .centeredHorizontally, animated: true)
    
  }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if (collectionView == brandCollectionView) {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath ) as! BrandCell
      cell.brandImagee.image = arrProducPhotos1[indexPath.row].image
      
      return cell
    } else if (collectionView == brandCollectionView2) {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prodectCell", for: indexPath ) as! ProdectsCell
      
     cell.Setupcell(photo: arrOffers[indexPath.row].image, price: arrOffers[indexPath.row].price, DisCrbsion: arrOffers[indexPath.row].info)

        return cell
     
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath ) as! HoomeCollectionViewCell
      cell.imig.image = arrProducPhotos[indexPath.row]
      
      return cell
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    if (collectionView == brandCollectionView){
      return 30
    } else if (collectionView == brandCollectionView2){
      return 20
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if (collectionView == brandCollectionView){
      return 30
    } else if (collectionView == brandCollectionView2){
      return 20
      
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if (collectionView == brandCollectionView) {
      return arrProducPhotos1.count
    }else  if (collectionView == brandCollectionView2) {
      return arrOffers.count
    } else {
      return arrProducPhotos.count
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
    
    //    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: cellWidth, height: cellHight)
    //    brandCollectionView.collectionViewLayout = layout
    brandCollectionView.isPagingEnabled = true
    
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    if (collectionView == brandCollectionView){
    selectedBrand = arrProducPhotos1[indexPath.row].name
    } else if (collectionView == brandCollectionView2) {
      selectedPreodect = arrOffers[indexPath.row]
    }
    return true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showPhone":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrProdects
        vc.selectedType = "Phone"
        vc.page = "Type"
        vc.selectedBrand = ""
        
      }
    case "showTablet":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrProdects
        vc.selectedType = "Tablet"
        vc.page = "Type"
        vc.selectedBrand = ""
      }
      
    case "showAccessories":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrProdects
        vc.selectedType = "Accessories"
        vc.page = "Type"
        vc.selectedBrand = ""
      }
      
    case "showCardGame":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrProdects
        vc.selectedType = "CardGame"
        vc.page = "Type"
        vc.selectedBrand = ""
      }
      
    case "showProdect1":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrProdects
        vc.selectedType = ""
        vc.page = "Brand"
        vc.selectedBrand = selectedBrand
      }
    case "arrProducPhotos2":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrOffers
        vc.selectedType = ""
        vc.page = "ALL"
        vc.selectedBrand = ""
      }
    case "showDeatil2":
      if let vc = segue.destination as? LastnViewController {
        vc.arri1 = selectedPreodect
      }
    default:
      print("default")
    }
    
    
  }
  
  
  //showCardGame
  
}




