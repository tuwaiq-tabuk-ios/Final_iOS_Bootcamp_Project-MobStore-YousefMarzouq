//
//  InfoFielViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 15/05/1443 AH.
//

import UIKit

class InfoFielViewController: UIViewController {

  
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
  
  override func viewDidLoad() {
        super.viewDidLoad()

      
      
      
      
    }
    
}

