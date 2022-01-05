//
//  BrandVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 05/05/1443 AH.
//

import UIKit

class BrandVC: UIViewController,
               UICollectionViewDelegate,
               UICollectionViewDataSource {
  
  
  @IBOutlet weak var collchinBrandView: UICollectionView!
  
  
  
  
  
  var arryPhone = [Phone] ()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collchinBrandView.delegate = self
    collchinBrandView.dataSource = self
    
    
    arryPhone.append(Phone(photo: UIImage(named: "Apple_brand")!,brand:"Apple"))
    arryPhone.append(Phone(photo: UIImage(named: "Honor-Logo")!,
                           brand:"Honor"))
    arryPhone.append(Phone(photo: UIImage(named: "Huawei_Brand")!,
                           brand:"Huawei"))
    arryPhone.append(Phone(photo: UIImage(named: "infinix")!,
                           brand:"Infinix"))
    arryPhone.append(Phone(photo: UIImage(named: "Itel_Brand")!,
                           brand:"Itel"))
    arryPhone.append(Phone(photo: UIImage(named: "Lenovo_logo")!,
                           brand:"Lenovo"))
    arryPhone.append(Phone(photo: UIImage(named: "nokia")!,
                           brand:"Nokia"))
    arryPhone.append(Phone(photo: UIImage(named: "oppo")!,
                           brand:"Oppo"))
    arryPhone.append(Phone(photo: UIImage(named: "Samsung_brand")!,
                           brand:"Samsung"))
    arryPhone.append(Phone(photo: UIImage(named: "Vivo_Logo")!,
                           brand:"Vivo"))
    arryPhone.append(Phone(photo: UIImage(named: "xiaomi_brand")!,
                           brand:"Xiaomi"))
    
    
    configureSize(numOfHorizontsalCells: 2, marginBetweenCells: 0)
    
    
  }
  
  
  //  var arrBrand = [UIImage(named: "apple")!,
  //                  UIImage(named: "apple")!]
  //
  var arrProdects:[Product] = Product.getProducts()
  
  
  
  var selectedBrand:String!
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arryPhone.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Brandd", for: indexPath) as! BrandVCCell
    
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
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arr = arrProdects
        vc.selectedType = ""
        vc.page = "Brand"
        vc.selectedBrand = selectedBrand
        
      }
    default:
      print("default")
    }
    
    
  }
  

  
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
    
    layout.itemSize = CGSize(width: cellWidth, height: cellHight)
    collchinBrandView.collectionViewLayout = layout
   
    
    
  }
  
}
