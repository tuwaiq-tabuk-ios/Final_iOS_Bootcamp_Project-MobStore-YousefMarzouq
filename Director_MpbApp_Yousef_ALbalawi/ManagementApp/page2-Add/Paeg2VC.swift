//
//  Paeg2VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 27/05/1443 AH.
//

import UIKit
import Firebase
import PhotosUI

class Paeg2VC: UIViewController ,
               PHPickerViewControllerDelegate,
               UINavigationControllerDelegate ,
               UICollectionViewDelegate ,
               UICollectionViewDataSource,
               UIPickerViewDataSource ,
               UIPickerViewAccessibilityDelegate,
               UITextFieldDelegate {
  
  
  var carntindX = 0
  let pickerTayp = UIPickerView()
  var arryTayp = ["Tablet","Phone","Accessories","CardGame"]

  
  
  
  @IBOutlet weak var tayp: UITextField!
  
  @IBOutlet weak var collP2: UICollectionView!

  @IBOutlet weak var countItme: UITextField!
  @IBOutlet weak var brand: UITextField!
  @IBOutlet weak var info: UITextField!
  @IBOutlet weak var praice: UITextField!
  @IBOutlet weak var productImage: UIImageView!

  
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var brandLabel: UILabel!
  var images:[UIImage] = [UIImage]()
  var prodectImage = false

  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let toolbar = UIToolbar ()
    toolbar.sizeToFit()
    let dane = UIBarButtonItem(title: "Done",
                               style: .plain,
                               target: self,
                               action: #selector(clus))
    toolbar.setItems([dane], animated: true)
    tayp.inputView = pickerTayp
    pickerTayp.delegate = self
    pickerTayp.dataSource = self
    collP2.delegate = self
    collP2.dataSource = self
    tayp.inputAccessoryView = toolbar
    
  }
  @objc func clus () {
    tayp.text = arryTayp[carntindX]
    view.endEditing(true)
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return images.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cll2 = collP2.dequeueReusableCell(withReuseIdentifier: "P2",
                                          for: indexPath) as! P2CollectionViewCell
    cll2.deleteButton.tag = indexPath.row
    cll2.imgP2.image = images[indexPath.row]
    return cll2
  }
  
  
  
  @IBAction func imagPage1(_ sender: UIButton) {
    prodectImage = true
    addFoto()
  }
  @IBAction func imagsPage1(_ sender: UIButton) {
    prodectImage = false
    addFoto()
  }
  
  
  @IBAction func addButtonPreased(_ sender: Any) {
    
    addToDatabase()
  }
  
  func addFoto() {
    let alert = UIAlertController(title: "Take Poto From",
                                  message: nil,
                                  preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera",
                                  style: .default,
                                  handler: { action in self.getimage(type: .camera)
                                    
                                    
                                  }))
    alert.addAction(UIAlertAction(title: "photo Library",
                                  style: .default,handler: { action in self.getimage(type: .photoLibrary)
                                    
                                    
                                  }))
    alert.addAction(UIAlertAction(title: "cancel",
                                  style: .cancel, handler: nil))
    present(alert, animated: true,
            completion: nil)
  }
  
  
  func getimage(type:UIImagePickerController.SourceType){
    var configuration = PHPickerConfiguration()
    if prodectImage {
      configuration.selectionLimit = 1
    } else {
      configuration.selectionLimit = 5
    }
    configuration.filter = .images
    let photoPicker = PHPickerViewController(configuration: configuration)
    photoPicker.delegate = self
    present(photoPicker, animated: true, completion: nil)
    
  }
  
  func picker(_ picker: PHPickerViewController,
              didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true,
            completion: nil)
    if prodectImage {
      if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
        result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
          if let image = image as? UIImage {
            
            DispatchQueue.main.async {
              self.productImage.image = image
            }
          }
        }
        
      }
    }else {
      for result in results {
        result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
          if let image = image as? UIImage {
            
            DispatchQueue.main.async {
              self.images.append(image)
              self.collP2.reloadData()
              
            }
            
          }
          
        }
        
      }
    }
    
  }
  
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    
    
    return arryTayp.count
  }
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return arryTayp[row]
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int,
                  inComponent component: Int) {
    carntindX = row
    tayp.text = arryTayp[row]
  }
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
  func addToDatabase() {
    
    let db = Firestore.firestore()
    let storeage = Storage.storage()
    let documentID = UUID().uuidString
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
    
    db.collection("Prodects").document(documentID).setData([
      "info": self.info.text! ,
      "price": Double(self.praice.text!) ?? 0,
      "brand": self.brand.text!,
      "type":self.tayp.text!,
      "count":Int(self.countItme.text!),
      "isFavorite":false,
      "Offers":false
    ], merge: true)
    
    var imageID = ""
    if imageID == "" {
      imageID = UUID().uuidString
    }
    
    let storeageRF = storeage.reference().child(documentID).child(imageID)
    let imageData = productImage.image?.jpegData(compressionQuality: 0.5)
    storeageRF.putData(imageData!, metadata: uploadMetadata) { metadata, error in
      if error != nil {
      } else {
        storeageRF.downloadURL { url, error in
          if error != nil {
          } else {
            db.collection("Prodects").document(documentID).setData([
              "image": url!.absoluteString
            ], merge: true)
          }
        }
        
      }
    }
    
    
    var imagesData = [Data]()
    for image in images {
      let data = image.jpegData(compressionQuality: 0.5)
      imagesData.append(data!)
    }
    var imagesURL = [String]()
    for data in imagesData {
      imageID = UUID().uuidString
      let storeageRF = storeage.reference().child(documentID).child(imageID)
      storeageRF.putData(data, metadata: uploadMetadata) { metadata, error in
        if error != nil {
        } else {
          storeageRF.downloadURL { url, error in
            if error != nil {
            } else {
              imagesURL.append(url!.absoluteString)
              db.collection("Prodects").document(documentID).setData([
                "images": imagesURL
              ], merge: true)
            }
          }
          
        }
      }
      
    }
    
    
    
    
    
    
    
    
    
    
  }
}

