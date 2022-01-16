//
//  EndTransactionVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 16/05/1443 AH.
//

import UIKit
import Firebase
import SDWebImage


class EndTransactionVC: UIViewController,
                           UICollectionViewDelegate,
                           UICollectionViewDataSource {
  
  
  
  // MARK: - Properties
  
  var arrayCarts:Product!
  var conter = 0
  
 
  // MARK: - IBOutlet
  
  @IBOutlet weak var textContty: UITextField!
  @IBOutlet weak var brandButton: UIButton!
  @IBOutlet weak var ditelsLebul: UILabel!
  @IBOutlet weak var collcionLast: UICollectionView!
  @IBOutlet weak var prisButoon: UILabel!
    
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
        super.viewDidLoad()
    collcionLast.delegate = self
    collcionLast.dataSource = self
    hideKeyboardWhenTappedAround()
    }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    ditelsLebul.text = arrayCarts.info
    prisButoon.text = "\(arrayCarts.price) SAR "
  }
  
  
  // MARK: - IBAction
  
  @IBAction func plasPessd(_ sender: UIButton) {
    addOneToCounter ()
  }
  
  
  @IBAction func munasPressd(_ sender: UIButton) {
    discont ()
  }
  
  
  @IBAction func addCartPressd(_ sender: UIButton) {
    let db = Firestore.firestore()
    guard let auth = Auth.auth().currentUser else {
      print("~~~~~ Alert Please SignIn")
      return
    }
    let document = db.collection("Carts").document(auth.uid)
      document.setData( ["carts": FieldValue.arrayUnion([arrayCarts.id])], merge: true)
  }

  
  // MARK: - functions
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  return arrayCarts.images.count
  }
 
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   let cll = collectionView.dequeueReusableCell(withReuseIdentifier: "lastpershn", for: indexPath) as! EndTransactionCollectionVCell
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    cll.imgLast.sd_setImage(with: URL(string: arrayCarts.images[indexPath.row]), placeholderImage:animatedImage)
    return cll
  }
  

  func addOneToCounter () {
    conter += 1
    textContty.text = conter .description
  }
  
  
  func discont () {
    if conter != 0 {
      conter -= 1
      textContty.text = conter.description
    }
  }
}
