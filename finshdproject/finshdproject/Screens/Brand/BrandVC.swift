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
  
  
  // MARK: - Properties
  
  var arrayBrandPictures = [Phone] ()
  var arrayProdects:[Product] = Product.getProducts()
  var selectedBrand:String!
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var collchinBrandView: UICollectionView!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    collchinBrandView.delegate = self
    collchinBrandView.dataSource = self
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Apple_Brand")!,brand:"Apple"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Huawei_Brand")!,
                                    brand:"Honor"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Infinix_Brand")!,
                                    brand:"Huawei"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Honor_Brand")!,
                                    brand:"Infinix"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Nokia_Brand")!,
                                    brand:"Itel"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Lenovo_Brand")!,
                                    brand:"Lenovo"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Itel_Brand")!,
                                    brand:"Nokia"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Oppo_Brand")!,
                                    brand:"Oppo"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Samsung_Brand")!,
                                    brand:"Samsung"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Vivo_Brand")!,
                                    brand:"Vivo"))
    arrayBrandPictures.append(Phone(photo: UIImage(named: "Xiaomi_Brand")!,
                                    brand:"Xiaomi"))
    configureSize(numOfHorizontsalCells: 2, marginBetweenCells: 0)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showProdect":
      if let vc = segue.destination as? DisplayProductsVC {
        vc.arrayAllPhone = arrayProdects
        vc.selectedType = ""
        vc.page = "Brand"
        vc.selectedBrand = selectedBrand
      }
    default:
      print("default")
    }
  }
  
  
  // MARK: - functions
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return arrayBrandPictures.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Brandd",
                                                  for: indexPath) as! BrandVCCell
    let data = arrayBrandPictures[indexPath.row]
    cell.imageBrand.image = data.photo
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      shouldSelectItemAt indexPath: IndexPath) -> Bool {
    selectedBrand = arrayBrandPictures[indexPath.row].brand
    return true
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
