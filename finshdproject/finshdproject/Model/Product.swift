//
//  Prodects.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 08/05/1443 AH.
//

import UIKit
import Firebase

var products:[Product] = [Product]()

class Product:Equatable {
  static func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.id == rhs.id
      && lhs.image == rhs.image
      && lhs.info == rhs.info
      && lhs.price == rhs.price
      && lhs.brand == rhs.brand
      && lhs.type == rhs.type
      && lhs.Offers == rhs.Offers
      && lhs.images == rhs.images
      && lhs.isFavorite == rhs.isFavorite
  }
  
  
  
  let id:String
  let image:String
  let info:String
  let price:Double
  let brand:String
  let type:String
  let Offers:Bool
  let images:[String]
  var isFavorite:Bool
  
  
  init(id:String,image:String,
       info:String,
       price:Double,
       brand:String,
       type:String,
       Offers:Bool,
       images:[String],
       isFavorite:Bool) {
    self.id = id
    self.image = image
    self.info = info
    self.price = price
    self.brand = brand
    self.type = type
    self.Offers = Offers
    self.images = images
    self.isFavorite = isFavorite
  }
  
  
  static func getProducts() -> [Product] {
    return products
  }
}

