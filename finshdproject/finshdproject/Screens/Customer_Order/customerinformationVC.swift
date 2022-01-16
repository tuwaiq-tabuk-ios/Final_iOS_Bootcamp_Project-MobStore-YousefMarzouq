//
//  customerinformationVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 02/06/1443 AH.
//

import UIKit

class customerinformationVC: UIViewController {
  
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var textNameCoustmer: UITextField!
  @IBOutlet weak var textNamburCoustmer: UITextField!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  // MARK: - IBAction
  
  @IBAction func clusPageditelsCoustmar(_ sender: Any) {
    dismiss(animated: true,
            completion: nil);
  }
}
