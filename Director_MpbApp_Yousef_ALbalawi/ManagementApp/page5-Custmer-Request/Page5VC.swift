//
//  Page5VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 29/05/1443 AH.
//

import UIKit
import Firebase

class Page5VC: UIViewController,
               UICollectionViewDelegate,
               UICollectionViewDataSource {
  
  
  var array = [[String:Any]]()
  var arri3:[Cart]!
  var totlprice:Double = 0

  
  
  
  @IBOutlet weak var collectionPage5: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionPage5.delegate = self
    collectionPage5.dataSource = self
    
  }
  
  
  

  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 1
 
  
  }
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cll = collectionPage5.dequeueReusableCell(withReuseIdentifier: "collectionPage5", for: indexPath) as! Page5CollectionViewCell
    
    
     
    cll.nameOFitme.text =  arri3[indexPath.row].product.info
     cll.praicOFitme.text = "\(arri3[indexPath.row].product.price) SR"

    return cll
  }
  
  
  
}
