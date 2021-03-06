//
//  ForgetPasswordVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 15/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth


class ForgetPasswordVC: UIViewController {
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var forGetTextField: UITextField!
  
  
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
  }
  
  
  // MARK: - IBAction
  
  @IBAction func forgitPressd(_ sender: UIButton) {
    
    let auth = Auth.auth()
    auth.sendPasswordReset(withEmail: forGetTextField.text!) { (error) in
      if let error = error {
        
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction((UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)))
        self.present(alert,
                     animated: true,
                     completion: nil)
        return
      }
      
      let alert = UIAlertController(title: "Succesfully",
                                    message: "A password reset email has been sent!",
                                    preferredStyle: UIAlertController.Style.alert)
      
      alert.addAction((UIAlertAction(title: "OK",
                                     style: .default,handler: nil)))
      self.present(alert, animated: true,
                   completion: nil)
    }
  }
  
  
  @IBAction func goTosingin(_ sender: Any) {
    
    let storyboard = UIStoryboard(name: "Main",
                                  bundle: nil)
    
    let vc = storyboard.instantiateViewController(identifier: "Login")
    vc.modalPresentationStyle = .overFullScreen
    
    let parentVC = presentingViewController
    dismiss(animated: true) {
      parentVC!.present(vc,
                        animated: true)
    }  }
  
  
  @IBAction func closePege(_ sender: Any) {
    
    dismiss(animated: true,
            completion: nil);
  }
}
