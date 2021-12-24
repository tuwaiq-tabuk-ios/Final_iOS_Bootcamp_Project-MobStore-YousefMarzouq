//
//  CollchinBrand.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 05/05/1443 AH.
//

import UIKit

class CollchinBrand: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
  
  @IBOutlet weak var collchinBrandView: UICollectionView!
  
  
  
  
  
  var arryPhone = [Phne] ()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collchinBrandView.delegate = self
    collchinBrandView.dataSource = self
    
    
    arryPhone.append(Phne(photo: UIImage(named: "Apple_brand")!,brand:"Apple"))
    arryPhone.append(Phne(photo: UIImage(named: "Honor-Logo")!,brand:"Honor"))
    arryPhone.append(Phne(photo: UIImage(named: "Huawei_Brand")!,brand:"Huawei"))
    arryPhone.append(Phne(photo: UIImage(named: "infinix")!,brand:"Infinix"))
    arryPhone.append(Phne(photo: UIImage(named: "Itel_Brand")!,brand:"Itel"))
    arryPhone.append(Phne(photo: UIImage(named: "Lenovo_logo")!,brand:"Lenovo"))
    arryPhone.append(Phne(photo: UIImage(named: "nokia")!,brand:"Nokia"))
    arryPhone.append(Phne(photo: UIImage(named: "oppo")!,brand:"Oppo"))
    arryPhone.append(Phne(photo: UIImage(named: "Samsung_brand")!,brand:"Samsung"))
    arryPhone.append(Phne(photo: UIImage(named: "Vivo_Logo")!,brand:"Vivo"))
    arryPhone.append(Phne(photo: UIImage(named: "xiaomi_brand")!,brand:"Xiaomi"))
    
    
    configureSize(numOfHorizontsalCells: 2, marginBetweenCells: 0)
    
    
  }
  
  
//  var arrBrand = [UIImage(named: "apple")!,
//                  UIImage(named: "apple")!]
//  
  var arrProdects:[Prodects] = Prodects.getarray()
  
  
  
  var selectedBrand:String!
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arryPhone.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Brandd", for: indexPath) as! BrandViewCell
    
    let data = arryPhone[indexPath.row]
    cell.imageBrand.image = data.photo
    return cell
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    selectedBrand = arryPhone[indexPath.row].brand
    return true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showProdect":
      if let vc = segue.destination as? ViewController {
        vc.arr = arrProdects
        vc.selectedType = ""
        vc.page = "Brand"
        vc.selectedBrand = selectedBrand
        
      }
    default:
      print("default")
    }
    
    
  }
  
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
  //      return 0
  //
  //  }
  //
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
  //      return 0
  //   }
  
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      return layout.itemSize
    } else {
      return .zero
    }
  }
  
  
  
  func configureSize(numOfHorizontsalCells:CGFloat,
                     marginBetweenCells:CGFloat) {
    print("\n \(#function)")
    
    let layout = UICollectionViewFlowLayout()
    
    let totalMarginBetweenCells:CGFloat = marginBetweenCells * (numOfHorizontsalCells - 1)
    
    
    let marginPerCell: CGFloat = totalMarginBetweenCells / numOfHorizontsalCells
    
    
    let frameWidth = view.frame.width
    
    let cellWidth = frameWidth / numOfHorizontsalCells - marginPerCell
    
    let cellHight = frameWidth / numOfHorizontsalCells
    layout.minimumLineSpacing = marginPerCell
    layout.minimumInteritemSpacing = marginPerCell
    
    layout.estimatedItemSize = .zero
    
    //    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: cellWidth, height: cellHight)
    collchinBrandView.collectionViewLayout = layout
    //    collchinBrandView.isPagingEnabled = true
    
    
  }
  
}

struct Phne {
  let photo: UIImage
  let brand: String
}



