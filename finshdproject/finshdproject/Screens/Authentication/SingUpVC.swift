//
//  SingUpVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 15/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class SingUpVC: UIViewController {
  
  @IBOutlet weak var fristName: UITextField!
  @IBOutlet weak var familyName: UITextField!
  @IBOutlet weak var customerPhone1: UITextField!
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    errorLabel.alpha = 0
    
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func supscribeNow(_ sender: Any) {
    if email.text?.isEmpty == true {
      print("no")
      return
    }
    if password.text?.isEmpty == true{
      print("no")
      return
      
    }
    sigUp()
    
  }
  
  
  @IBAction func ClosPaeg(_ sender: Any) {
    dismiss(animated: true, completion: nil);
  }
  
  
  @IBAction func singin(_ sender: Any) {
    let storyboratd = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard?.instantiateViewController(identifier: "Login")
    vc?.modalPresentationStyle = .overFullScreen
    present(vc!, animated: true)
  }
  
  func sigUp () {
    let fristName = fristName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let lastname = familyName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let customerPhone = customerPhone1.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    Auth.auth().createUser(withEmail: email, password: password) {  (authResult ,error) in
      if error != nil {
        self.errorLabel.alpha = 1
        self.errorLabel.text = error?.localizedDescription
      } else {
        let db = Firestore.firestore()
        db.collection("users").document(authResult!.user.uid).setData(  ["firstname":fristName,"lastname":lastname,"phone":self.customerPhone1.text!,"uid":authResult!.user.uid],merge:true) {
          (error) in
          if error != nil {
            self.errorLabel.alpha = 1
            self.errorLabel.text = error?.localizedDescription
          }else {
            //          self.checkUoserInfo()
            
            self.dismiss(animated: true, completion: nil)
            
          }
        }
      }
    }
  }
  
  
  func checkUoserInfo () {
    let storyboratd = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard?.instantiateViewController(withIdentifier: "NewUser")
    vc?.modalPresentationStyle = .overFullScreen
    present(vc!, animated: true)
  }
}
