//
//  PurchaseInformationVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 23/05/1443 AH.
//

import UIKit





class PurchaseInformationVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
 

  @IBOutlet weak var tabelView: UITableView!
 
  
  struct purchase {
    let labul : String
    let button : String
  }
    
  let data1 : [purchase] = [
    purchase(labul: "ds", button: "Selection"),
    purchase(labul: "dsf", button: "Selection"),
    purchase(labul: "dsf", button: "Selection"),
    purchase(labul: "dsf", button: "Selection"),
  ]
  
  override func viewDidLoad() {
        super.viewDidLoad()
    tabelView.delegate = self
    tabelView.dataSource = self
    
    }
    

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data1.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let sunde = data1[indexPath.row]
    let cll = tableView.dequeueReusableCell(withIdentifier: "TCll", for: indexPath) as! PurchaseInformationCellVCTablewCell
    cll .label.text = sunde.labul
    cll.button.tag = indexPath.row
    cll.button.setTitle(sunde.button, for: .normal)
    return cll
  }
  
}
