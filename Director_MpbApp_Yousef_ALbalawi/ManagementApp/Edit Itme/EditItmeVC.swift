//
//  Paeg3VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 27/05/1443 AH.
//

import UIKit
import PhotosUI
import Firebase


class EditItme: UIViewController ,
                UINavigationControllerDelegate ,
                UITextFieldDelegate{
  
  
  // MARK: - Properties
  
  var prodect:Product?
  var prodectImage = false
  var ID:String!
  var images:[UIImage] = [UIImage]()
  var carntindX = 0
  let pickerTayp = UIPickerView()
  var arryTayp = ["Tablet","Phone","Accessories","CardGame"]
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var tayp: UITextField!
  @IBOutlet weak var CollP3: UICollectionView!
  @IBOutlet weak var countItme: UITextField!
  @IBOutlet weak var brand: UITextField!
  @IBOutlet weak var info: UITextField!
  @IBOutlet weak var praice: UITextField!
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
    tayp.inputView = pickerTayp
    pickerTayp.delegate = self
    pickerTayp.dataSource = self
    CollP3.delegate = self
    CollP3.dataSource = self
    tayp.inputAccessoryView = toolbar
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getData()
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    getData()
  }
  
  
  @objc func clus () {
    tayp.text = arryTayp[carntindX]
    view.endEditing(true)
  }
  
  
  // MARK: - IBAction
  
  @IBAction func imagPage2(_ sender: Any) {
    prodectImage = true
    addFoto ()
  }
  @IBAction func imagsPage2(_ sender: Any) {
    prodectImage = false
    addFoto ()
  }
  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    images.remove(at: sender.tag)
    CollP3.reloadData()
  }
  @IBAction func editButtonTapped(_ sender: Any) {
    editDatabase()
  }
  
  
  func getData() {
    productImage.sd_setImage(with: URL(string: prodect?.image ?? ""),
                             placeholderImage: UIImage(named: ""))
    countItme.text = "0"
    brand.text = prodect?.brand
    info.text = prodect?.info
    praice.text = "\(prodect?.price ?? 0)"
    infoLabel.text = info.text
    priceLabel.text = praice.text
    countLabel.text = "5"
    brandLabel.text = brand.text
    tayp.text = prodect?.type
    ID = prodect?.id
    self.images.removeAll()
    if prodect?.images.count ?? 0 > 0 {
      for image in prodect!.images {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: image)) { image, error,
          cache, url in
          self.images.append(image!)
          self.CollP3.reloadData()
        }
      }
    }
    CollP3.reloadData()
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      self.prodect = nil
    }
  }
  
  
  func editDatabase() {
    let db = Firestore.firestore()
    let storeage = Storage.storage()
    let documentID = ID!
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
    db.collection("Prodects").document(documentID).setData([
      "info": self.info.text! ,
      "price": Double(self.praice.text!) ?? 0,
      "brand": self.brand.text!,
      "type":self.tayp.text!,
      "count":Int(self.countItme.text!)
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
  
  
  func addFoto() {
    let alert = UIAlertController(title: "Take Poto From",
                                  message: nil,
                                  preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera",
                                  style: .default,
                                  handler: { action in self.getimage(type: .camera)}))
    alert.addAction(UIAlertAction(title: "photo Library",
                                  style: .default,handler: { action in self.getimage(type: .photoLibrary
                                  )}))
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
}


// MARK: - extensionPickerView

extension EditItme : PHPickerViewControllerDelegate ,
                     UIPickerViewDataSource,
                     UIPickerViewAccessibilityDelegate {
  
  
  // MARK: - functionsPickerView
  
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
              self.CollP3.reloadData()
              
            }
          }
        }
      }
    }
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
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
}


// MARK: - extensionCollectionView

extension EditItme :  UICollectionViewDelegate ,
                      UICollectionViewDataSource {
  
  
  // MARK: - functionsCollectionView
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return images.count ?? 0
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cll3 = CollP3.dequeueReusableCell(withReuseIdentifier: "P3",
                                          for: indexPath) as! EditItmeCollectionViewCell
    cll3.deleteButton.tag = indexPath.row
    cll3.imgP3.image = images[indexPath.row]
    return cll3
  }
}
