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
  
  
  // MARK: - Properties
  
  let db = Firestore.firestore()
  let auth = Auth.auth().currentUser
  let newName = UserInfo.self
  
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var snapButton: UIButton!
  @IBOutlet weak var viewadd: UIView!
  @IBOutlet weak var textLB: UILabel!
  
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    
    textLB.text = " Welcome to the Siri mobile app "
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
  
  
  // MARK: - IBAction
  
  @IBAction func logOutPassword(_ sender: UIButton) {
   
    let auth = Auth.auth()
    do {
      try auth.signOut()
      UserDefaults.standard.removeObject(forKey: "email")
      UserDefaults.standard.removeObject(forKey: "password")
      UserDefaults.standard.synchronize()
      let storyboard = UIStoryboard(name: "Main",
                                    bundle: nil)
      let vc = storyboard.instantiateViewController(identifier: "Home")
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true)
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
  
  
  @IBAction func location(_ sender: UIButton) {
    let myWebsite = URL(string: "https://goo.gl/maps/74WLP7MuauCc4yNK8")
    UIApplication.shared.openURL(myWebsite!)
  }
  
  

  
  @IBAction func singUPPassword(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main",
                                  bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "SingUp")
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true)
  }
  
  
  @IBAction func loginPassword(_ sender: Any) {
    _ = UIStoryboard(name: "Main",
                     bundle: nil)
    let vc = storyboard?.instantiateViewController(identifier: "Login")
    vc!.modalPresentationStyle = .overFullScreen
    present(vc!, animated: true)
  }
  
  
  @IBAction func WhatsAppPassword(_ sender: UIButton) {
    let myWebsite = URL(string: "https://api.whatsapp.com/qr/OB3ZS5SJOS6IF1")
    UIApplication.shared.openURL(myWebsite!)
  }
  
  
  @IBAction func ansta (_ sender: UIButton) {
    let myWebsite = URL(string: "https://www.linkedin.com/feed/")
    UIApplication.shared.openURL(myWebsite!)
  }
  
  
  @IBAction func snapshatPassword(_ sender: UIButton) {
    let myWebsite = URL(string: "https://www.snapchat.com/add/siri-support?share_id=OUFBOTQ0&locale=en_SA@calendar=gregorian")
    UIApplication.shared.openURL(myWebsite!)
  }
}

