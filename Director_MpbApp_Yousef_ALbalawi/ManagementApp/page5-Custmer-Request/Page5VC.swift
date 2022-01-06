//
//  Page5VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 29/05/1443 AH.
//

import UIKit

class Page5VC: UIViewController,
               UICollectionViewDelegate,
               UICollectionViewDataSource {
  
  
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
    cll.imgItm5.image = UIImage(named: "0020991_infinix-hot-10-play-64gb-4gb-ram-aegean-blue")
    cll.nameCastmer.text = "Yousef Albalawi"
    cll.namburPhone.text = "0560211162"
    cll.nameOFitme.text = "shdjkdmsla"
    cll.loucitonCoustmer.text = "Tabuk"
    
    cll.praicOFitme.text = "6500 SR"
    return cll
  }
}
