//
//  Paeg2VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 27/05/1443 AH.
//

import UIKit

class Paeg2VC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
  
  
  @IBOutlet weak var collP2: UICollectionView!
  
  
  @IBOutlet weak var nameItme: UITextField!
  @IBOutlet weak var brand: UITextField!
  @IBOutlet weak var info: UITextField!
  @IBOutlet weak var praice: UITextField!
  
 
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      collP2.delegate = self
      collP2.dataSource = self
    }
    
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
      let cll2 = collP2.dequeueReusableCell(withReuseIdentifier: "P2", for: indexPath) as! P2CollectionViewCell
    cll2.deleteButton.tag = indexPath.row
    cll2.imgP2.image = UIImage(named: "0020991_infinix-hot-10-play-64gb-4gb-ram-aegean-blue")
    return cll2
    }
  
  
  
  @IBAction func imagPage1(_ sender: UIButton) {
    addFoto()
  }

  
  @IBAction func imagsPage1(_ sender: UIButton) {
    addFoto()
  }
  
  func addFoto() {
      let alert = UIAlertController(title: "Take Poto From", message: nil, preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Camera", style: .default,handler: { action in self.getimage(type: .camera)
        
        
      }))
      alert.addAction(UIAlertAction(title: "photo Library", style: .default,handler: { action in self.getimage(type: .photoLibrary)
        
        
      }))
      alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
      present(alert, animated: true, completion: nil)
    }
  func getimage(type:UIImagePickerController.SourceType){
      let pickerCount = UIImagePickerController()
      pickerCount.sourceType = type
      pickerCount.allowsEditing = false
      pickerCount.delegate = self
      present(pickerCount, animated: true, completion: nil)
      
    }
 
}

