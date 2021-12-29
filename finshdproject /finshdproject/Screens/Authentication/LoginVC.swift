//
//  LoginVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 15/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

  
  @IBOutlet weak var email: UITextField!
  
  
  @IBOutlet weak var password: UITextField!
  
  
  @IBOutlet weak var errorLabel: UILabel!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
  
  @IBAction func forgetPassword(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "ForgetPassword")
    
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true)
    
  }
  
  
  @IBAction func closPege(_ sender: Any) {
    dismiss(animated: true, completion: nil);
  }
  
  
  @IBAction func login(_ sender: Any) {
    
   let emailClear = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let passwordClear = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    
    Auth.auth().signIn(withEmail: emailClear, password: passwordClear) { (result,error) in
      
      
      if error != nil {
        self.errorLabel.alpha = 1
        self.errorLabel.text = error?.localizedDescription
      } else {
        
        self.dismiss(animated: true, completion: nil);
      }
    }
    
  }
  
  
  
  
  @IBAction func singUp(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "SingUp")
    
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true)
    
  }
  
  func validateFileds () {
    
  }

}
