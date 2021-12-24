//
//  LastnViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 16/05/1443 AH.
//

import UIKit




class LastnViewController: UIViewController,
                           UICollectionViewDelegate,
                           UICollectionViewDataSource {

  @IBOutlet weak var textContty: UITextField!
  
  @IBOutlet weak var brandButton: UIButton!

  @IBOutlet weak var ditelsLebul: UILabel!


  @IBOutlet weak var collcionLast: UICollectionView!

  @IBOutlet weak var prisButoon: UILabel!

  var arri1:Prodects!
   
  var conter = 0

  override func viewDidLoad() {
        super.viewDidLoad()
    collcionLast.delegate = self
    collcionLast.dataSource = self

    

    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    ditelsLebul.text = arri1.info
    prisButoon.text = "\(arri1.price) SR"
  }

  @IBAction func plasPessd(_ sender: UIButton) {
    addOneToCounter ()
  }
  @IBAction func munasPressd(_ sender: UIButton) {
    discont ()
  }
  @IBAction func addCart(_ sender: UIButton) {
    
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return arri1.images.count
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   let cll = collectionView.dequeueReusableCell(withReuseIdentifier: "lastpershn", for: indexPath) as! LastPishonCollectionViewCell
    cll.imgLast.image = arri1.images[indexPath.row]
    return cll
  }

  func addOneToCounter () {
    conter += 1
    textContty.text = conter .description
    
  }
  
  
  func discont () {
    if conter != 0 {
      conter -= 1
      textContty.text = conter .description
      
    }
    
  }
  
}
