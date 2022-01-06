//
//  Paeg4VC.swift
//  Director_MpbApp_Yousef_ALbalawi
//
//  Created by Yousef Albalawi on 29/05/1443 AH.
//

import UIKit

class Paeg4VC: UIViewController,
               UITableViewDelegate,
               UITableViewDataSource,
               UISearchBarDelegate {
  
  
  @IBOutlet weak var serchBar: UISearchBar!
  
  @IBOutlet weak var Paeg4Table: UITableView!
  
  
  var arr = ["a","b","c","d"]
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Paeg4Table.delegate = self
    Paeg4Table.dataSource = self
    serchBar.delegate = self
    
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return arr.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cll = tableView.dequeueReusableCell(withIdentifier: "Paeg4Table",
                                            for: indexPath) as! Pege4TableViewCell
    cll.labe.text = arr[indexPath.row]
    
    return cll
  }
  
  
}
