//
//  customerinformationVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 02/06/1443 AH.
//

import UIKit

class customerinformationVC: UIViewController {

  
  
  
  @IBOutlet weak var textNameCoustmer: UITextField!
  
  @IBOutlet weak var textNamburCoustmer: UITextField!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
  @IBAction func clusPageditelsCoustmar(_ sender: Any) {
    dismiss(animated: true, completion: nil);

  }
  

}
