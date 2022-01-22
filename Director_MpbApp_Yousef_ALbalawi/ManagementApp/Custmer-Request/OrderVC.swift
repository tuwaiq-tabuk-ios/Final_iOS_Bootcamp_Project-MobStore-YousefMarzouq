//
//  OrderVC.swift
//  ManagementApp
//
//  Created by Marzouq Almukhlif on 15/06/1443 AH.
//

import UIKit
import SDWebImage

class OrderVC: UIViewController {
  
  
  @IBOutlet weak var customerName: UILabel!
  @IBOutlet weak var customerPhone: UILabel!
  @IBOutlet weak var orderNumber: UILabel!
  @IBOutlet weak var orderState: UILabel!
  @IBOutlet weak var totalAmount: UILabel!
  
  var order: Order!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    customerName.text = order.customerName
    customerPhone.text = order.customerPhone
    orderNumber.text = "\(order.orderNumber)"
    orderState.text = order.orderState
    totalAmount.text = order.totalAmount
    
  }
  
  
  
  
  @IBAction func showLocationPressed(_ sender: UIButton) {
    
    
    // open Google Maps
    
    let canOpenGoogelMaps = UIApplication.shared.canOpenURL(URL(string:"comgooglemapsurl://maps.google.com/?q=@\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    
    if canOpenGoogelMaps {
      UIApplication.shared.openURL(URL(string:"comgooglemapsurl://maps.google.com/?q=@\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    } else {
      UIApplication.shared.openURL(URL(string:"https://maps.google.com/?q=@\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    }
    
    // open Apple Maps
    let canOpenAppleMaps = UIApplication.shared.openURL(URL(string:"maps://maps?q=\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    
    if canOpenAppleMaps {
      UIApplication.shared.openURL(URL(string:"maps://maps?q=\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    } else {
      UIApplication.shared.openURL(URL(string:"https://maps.apple.com/maps?q=\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    }
    
    
    UIApplication.shared.openURL(URL(string:"maps://maps?q=\(order.shippingAddress[0]),\(order.shippingAddress[1])")!)
    
  }
  
}

// MARK: - extensionCollectionView


extension OrderVC : UICollectionViewDelegate,
                    UICollectionViewDataSource {
  
  
  // MARK: - functionscollectionView
  
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return order.orders.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell",
                                                  for: indexPath) as! OrderCell
    let product = order.orders[indexPath.row].product
    cell.productImage.sd_setImage(with: URL(string: product.image),
                                  placeholderImage: UIImage())
    cell.productBrand.text = product.brand
    cell.productInfo.text = product.info
    cell.productAmount.text = "\(order.orders[indexPath.row].counts)"
    let price = Double(order.orders[indexPath.row].counts) * product.price
    cell.productPrice.text = " \(price) SR"
    
    return cell
  }
  
  
}
