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
              UINavigationControllerDelegate ,
                  UITextFieldDelegate {
  
  
  // MARK: - Properties
  
  var images:[UIImage] = [UIImage]()
  var prodectImage = false
  var carntindX = 0
  let pickerTayp = UIPickerView()
  var arryTayp = ["Tablet","Phone","Accessories","CardGame"]
  
  
  
  // MARK: - IBOutlet

  @IBOutlet weak var taypUITextField: UITextField!
  @IBOutlet weak var collAddItem: UICollectionView!
  @IBOutlet weak var countItmeTextField: UITextField!
  @IBOutlet weak var brandTextField: UITextField!
  @IBOutlet weak var infoTextField: UITextField!
  @IBOutlet weak var praiceTextField: UITextField!
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var brandLabel: UILabel!
  
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let toolbar = UIToolbar ()
    toolbar.sizeToFit()
    let dane = UIBarButtonItem(title: "Done",
                               style: .plain,
                               target: self,
                               action: #selector(clus))
    toolbar.setItems([dane], animated: true)
    taypUITextField.inputView = pickerTayp
    pickerTayp.delegate = self
    pickerTayp.dataSource = self
    collAddItem.delegate = self
    collAddItem.dataSource = self
    taypUITextField.inputAccessoryView = toolbar
  }
  
  
  @objc func clus () {
    taypUITextField.text = arryTayp[carntindX]
    view.endEditing(true)
  }
  
  
  // MARK: - IBAction

  @IBAction func imagPage1(_ sender: UIButton) {
    prodectImage = true
    addFoto()
  }
  @IBAction func imagsPage1(_ sender: UIButton) {
    prodectImage = false
    addFoto()
  }
  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    images.remove(at: sender.tag)
    collAddItem.reloadData()
  }
  @IBAction func addButtonPreased(_ sender: Any) {
    addToDatabase()
  }

  
  // MARK: - functions

  func addFoto() {
    let alert = UIAlertController(title: "Take Poto From",
                                  message: nil,
                                  preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera",
                                  style: .default,
                                  handler: { action in self.getimage(type: .camera)}))
    alert.addAction(UIAlertAction(title: "photo Library",
                                  style: .default,handler: { action in self.getimage(type: .photoLibrary)}))
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
              self.collAddItem.reloadData()
              
            }
          }
        }
      }
    }
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
      "info": self.infoTextField.text! ,
      "price": Double(self.praiceTextField.text!) ?? 0,
      "brand": self.brandTextField.text!,
      "type":self.taypUITextField.text!,
      "count":Int(self.countItmeTextField.text!),
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


// MARK: - extensionCollectionView

extension Paeg2VC :  UICollectionViewDelegate ,
                     UICollectionViewDataSource {
  
  
  // MARK: - functionsCollectionView

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return images.count}
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cll2 = collAddItem.dequeueReusableCell(withReuseIdentifier: "P2",
                                               for: indexPath) as! P2CollectionViewCell
    cll2.deleteButton.tag = indexPath.row
    cll2.imgP2.image = images[indexPath.row]
    return cll2
  }
}


// MARK: - extensionPickerView

extension Paeg2VC : PHPickerViewControllerDelegate ,
                    UIPickerViewDataSource,
                    UIPickerViewAccessibilityDelegate {
  
  
  // MARK: - functionsPickerView

  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return arryTayp.count
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
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
    taypUITextField.text = arryTayp[row]
  }
}
