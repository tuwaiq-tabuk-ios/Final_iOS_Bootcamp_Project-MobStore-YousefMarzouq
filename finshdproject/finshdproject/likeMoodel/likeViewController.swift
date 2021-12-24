//
//  likeViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 19/05/1443 AH.
//

import UIKit

class likeViewController:UIViewController,
                         UICollectionViewDelegate,
                         UICollectionViewDataSource,
                         UICollectionViewDelegateFlowLayout{
 
  
  
  
  
  
  
  @IBOutlet weak var collcLikeView: UICollectionView!
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell22 = collcLikeView.dequeueReusableCell(withReuseIdentifier: "likeSho", for: indexPath) as! likeViewController
  }
  


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
