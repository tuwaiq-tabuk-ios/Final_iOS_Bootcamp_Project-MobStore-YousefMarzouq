//
//  SocialMediaVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 15/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth


class SocialMediaVC: UIViewController {
  
  @IBOutlet weak var snapButton: UIButton!
  
  @IBOutlet weak var viewadd: UIView!
  

  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let auth = Auth.auth().currentUser
    
    if auth?.uid != nil {
      snapButton.isHidden = false
      viewadd.isHidden = true
    } else {
      snapButton.isHidden = true
      viewadd.isHidden = false
      
    }
      
  }
  
  @IBAction func logOut(_ sender: UIButton) {
    let auth = Auth.auth()
        
        do {
          try auth.signOut()
          UserDefaults.standard.removeObject(forKey: "email")
          UserDefaults.standard.removeObject(forKey: "password")
          UserDefaults.standard.synchronize()
          
          snapButton.isHidden = false
          viewadd.isHidden = true
        } catch let signOutError {
          let alert = UIAlertController(title: "Error",
                                        message: signOutError.localizedDescription,
                                        preferredStyle: UIAlertController.Style.alert)
          self.present(alert,
                       animated: true,
                       completion: nil)
        }
  }
  
  
  
  
  @IBAction func settings(_ sender: Any) {
    
  }
  @IBAction func location(_ sender: Any) {
    
  }
  
  @IBAction func myrequests(_ sender: Any) {
    
  }
  
  
  @IBAction func singUP(_ sender: Any) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "SingUp")
    
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true)
  }
  
  
  
  @IBAction func login(_ sender: Any) {
    let storyboratd = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(identifier: "Login")
    vc!.modalPresentationStyle = .overFullScreen
    present(vc!, animated: true)
  }
  
  
  @IBAction func WhatsApp(_ sender: UIButton) {
    let myWebsite = URL(string: "https://www.linkedin.com/feed/")
   UIApplication.shared.openURL(myWebsite!)
  }
  
  
  @IBAction func ansta (_ sender: UIButton) {
    let myWebsite = URL(string: "https://www.linkedin.com/feed/")
   UIApplication.shared.openURL(myWebsite!)
 
  }
  
  
  @IBAction func snapshat(_ sender: UIButton) {
    let myWebsite = URL(string: "https://www.linkedin.com/feed/")
   UIApplication.shared.openURL(myWebsite!)
 
  }
  
}

