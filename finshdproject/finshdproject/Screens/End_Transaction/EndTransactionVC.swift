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
  
  
  var selectedType:String!
  var arrTrulay:[String] = [String]()
  
  
  var arri1:Product!
  var DocumentReference: DocumentReference!
  
 

  @IBOutlet weak var textContty: UITextField!
  
  @IBOutlet weak var brandButton: UIButton!

  @IBOutlet weak var ditelsLebul: UILabel!


  @IBOutlet weak var collcionLast: UICollectionView!

  @IBOutlet weak var prisButoon: UILabel!

 
   
  var conter = 0

  override func viewDidLoad() {
        super.viewDidLoad()
    collcionLast.delegate = self
    collcionLast.dataSource = self

    

    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    ditelsLebul.text = arri1.info
    prisButoon.text = "\(arri1.price) "
  }
  
  

  @IBAction func plasPessd(_ sender: UIButton) {
    addOneToCounter ()
  }
  @IBAction func munasPressd(_ sender: UIButton) {
    discont ()
  }
  @IBAction func addCart(_ sender: UIButton) {
    
    let db = Firestore.firestore()
    guard let auth = Auth.auth().currentUser else {
      print("~~~~~ Alert Please SignIn")
      return
    }
    
    let document = db.collection("Carts").document(auth.uid)
                                                    
      document.setData( ["carts": FieldValue.arrayUnion([arri1.id])], merge: true)
    
      
    

  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

  return arri1.images.count
    
   
  }
 
  
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   let cll = collectionView.dequeueReusableCell(withReuseIdentifier: "lastpershn", for: indexPath) as! EndTransactionCollectionVCell
   
    
    
  
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    
    cll.imgLast.sd_setImage(with: URL(string: arri1.images[indexPath.row]), placeholderImage:animatedImage)

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
