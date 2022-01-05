//
//  PurchaseInformationVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 23/05/1443 AH.
//

import UIKit
import SDWebImage




class PurchaseInformationVC: UIViewController ,
                             UITableViewDataSource,
                             UITableViewDelegate {
  
  
  
  var conter = 1
  
  @IBOutlet weak var tabelView: UITableView!
  @IBOutlet weak var cllColleViewPInfo: UICollectionView!
  
  
  
  
  struct purchase {
    let labul : String
    let button : String
  }
  
  //   var tag1:data1 = [purchase]
  //
  let data1 : [purchase] = [
    purchase(labul: "Shipping Address",
             button: "Selection"),
    purchase(labul: "billing address",
             button: "Selection"),
    purchase(labul: "Payment method",
             button: "Selection"),
    purchase(labul: "Shipping way",
             button: "Selection"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabelView.delegate = self
    tabelView.dataSource = self
    cllColleViewPInfo.delegate = self
    cllColleViewPInfo.dataSource = self
    
  }
  
  
  @IBAction func presdButton(_ sender: UIButton) {
    
    
    print("~~ \(sender.tag)")
    if sender.tag == 0 {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "billingAddress")
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true)
      
    } else if sender.tag == 1{
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddress")
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true)
      
    } else if sender.tag == 2 {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "PaymentMethod")
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true)
      
    }else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "ShippingWay")
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true)
      
      
    }
  }
  
  
  
  
  
  
  
  
  
  @IBAction func plasBT(_ sender: Any) {
  }
  @IBAction func minusBT(_ sender: Any) {
  }
  @IBAction func rmoveBT(_ sender: Any) {
  }
  @IBAction func addLike(_ sender: Any) {
  }
  
  
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int
  ) -> Int {
    return data1.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    
    let sunde = data1[indexPath.row]
    let cll = tableView.dequeueReusableCell(withIdentifier: "TCll",for: indexPath) as! PurchaseInformationCellVCTablewCell
    cll .label.text = sunde.labul
    cll.button.tag = indexPath.row
    
    cll.button.setTitle(sunde.button, for: .normal)
   
    cll.button.addTarget(self, action: #selector(prssd(sender:)), for: .touchUpInside)
    return cll
  }
  
  
  @objc
  func prssd (sender:UIButton){
    
    print("pressd inDix \(sender.tag)")
    
  }
  
  var arri3:Product!
}

extension PurchaseInformationVC: UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cll1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CCll", for: indexPath) as! PurchaseInformationCellVC
    let animatedImage = SDAnimatedImage(contentsOfFile: "\(Bundle.main.bundlePath)/Loader1.gif")
    
   
//    cll1.imageCellPurchase.sd_setImage(with: URL(string: arri3.images[indexPath.row]), placeholderImage:animatedImage)

    cll1.plasButton.tag = indexPath.row
    cll1.mensButton.tag = indexPath.row
    cll1.countPurchase.text = "1"
    cll1.infoPurchase.text = "dfdsdfgdhdgfsafghjgfedwergt" //arri3.info
    cll1.praicPurchase.text =  "32456"//"\(arri3.price) SR"
    
    
    return cll1
  }
  
  @IBAction func plasButton(_ sender: UIButton) {
    let cll1 = cllColleViewPInfo!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! PurchaseInformationCellVC
    var conter = Int(cll1.countPurchase.text!)
    conter! += 1
    cll1.countPurchase.text = conter?.description
  }
  
  
  @IBAction func minusButton(_ sender: UIButton) {
    let cell = cllColleViewPInfo!.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! PurchaseInformationCellVC
    var conter = Int(cell.countPurchase.text!)
    if conter != 0 {
      conter! -= 1
      cell.countPurchase.text = conter?.description
    }
  }
  
  @IBAction func rmoveCollch(_ sender: UIButton) {
  }
  
  
  @IBAction func addToLike(_ sender: UIButton) {
  }
  
  
}
