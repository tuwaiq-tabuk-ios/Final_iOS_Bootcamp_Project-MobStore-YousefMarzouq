//
//  LoginVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 15/05/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    errorLabel.isHidden = true
  }
  
  
  // MARK: - IBAction
  
  @IBAction func forgetPassword(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "ForgetPassword")
    vc.modalPresentationStyle = .overFullScreen
    let parentVC = presentingViewController
    dismiss(animated: true) {
      parentVC!.present(vc, animated: true)
    }  }
  
  
  @IBAction func closPegePassword(_ sender: Any) {
    dismiss(animated: true, completion: nil);
  }
  
  
  @IBAction func loginPassword(_ sender: Any) {
    let emailClear = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let passwordClear = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    Auth.auth().signIn(withEmail: emailClear, password: passwordClear) { (result,error) in
      if error != nil {
        self.errorLabel.isHidden = false
        self.errorLabel.text = error?.localizedDescription
      } else {
        self.dismiss(animated: true, completion: nil);
      }
    }
  }
  
  
  @IBAction func singUpPassword(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "SingUp")
    vc.modalPresentationStyle = .overFullScreen
    let parentVC = presentingViewController
    dismiss(animated: true) {
      parentVC!.present(vc, animated: true)
    }
    
  }
}
