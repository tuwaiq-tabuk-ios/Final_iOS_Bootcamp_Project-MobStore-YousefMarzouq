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
  
  
  @IBOutlet weak var forGetLb: UITextField!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    
  }
  
  
  @IBAction func forgitPressd(_ sender: UIButton) {
    let auth = Auth.auth()
    auth.sendPasswordReset(withEmail: forGetLb.text!) { (error) in
      if let error = error {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        return
          alert.addAction((UIAlertAction(title: "OK", style: .default,handler: nil)))
          
          self.present(alert, animated: true, completion: nil)
      }
      let alert = UIAlertController(title: "Succesfully", message: "A password reset email has been sent!", preferredStyle: UIAlertController.Style.alert)
      
      alert.addAction((UIAlertAction(title: "OK", style: .default,handler: nil)))
      
      self.present(alert, animated: true, completion: nil)
      
    }
  }
  
  
  @IBAction func goTosingin(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "Login")
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true)
  }
  
  
  @IBAction func closPege(_ sender: Any) {
    dismiss(animated: true, completion: nil);
  }
  
}
