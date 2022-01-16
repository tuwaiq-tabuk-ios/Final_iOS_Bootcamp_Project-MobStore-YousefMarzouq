//
//  CardViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 29/05/1443 AH.
//

import UIKit

class CardViewController: UIViewController {
  
  
 
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
 
  // MARK: - IBAction
  
  @IBAction func clousPaeg(_ sender: Any) {
    dismiss(animated: true,
            completion: nil);
  }
  
  
  @IBAction func addNewCard(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main",
                                  bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "Card")
    vc.modalPresentationStyle = .overFullScreen
    present(vc,
            animated: true)
  }
  
  
  @IBAction func cardAddClus(_ sender: Any) {
    dismiss(animated: true,
            completion: nil);
  }
}
