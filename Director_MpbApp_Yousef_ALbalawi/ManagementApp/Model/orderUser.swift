//
//  orderUser.swift
//  ManagementApp
//
//  Created by Yousef Albalawi on 06/06/1443 AH.
//

import Foundation


import Foundation

struct Cart {
  let product:Product
  var count:Int
}


struct Order {
  let customerName: String
  let customerPhone: String
  let orderNumber: Int
  let orderState: String
  let billingAddress : [Double]
  let shippingAddress : [Double]
  let totalAmount: String
  let orders: [Cart]
}
