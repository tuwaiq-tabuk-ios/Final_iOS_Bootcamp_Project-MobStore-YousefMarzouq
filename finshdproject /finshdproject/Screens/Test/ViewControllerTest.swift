//
//  ViewControllerTest.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 08/05/1443 AH.
//

import UIKit
import SDWebImage
class ViewControllerTest: UIViewController {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var image: UIImageView!
  
  var arr:[Product]!
  var selectBrand:String!
  var arrSeleced:[Product] = [Product]()

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    arr.forEach { Prodectse in
//      if (Prodectse.brand == selectBrand && Prodectse.type == "Accessories") {
    if (Prodectse.brand == selectBrand) {
      arrSeleced.append(Product(id: Prodectse.id, image: Prodectse.image, info: Prodectse.info, price: Prodectse.price, brand: Prodectse.brand, type: Prodectse.type, Offers: Prodectse.Offers, images: Prodectse.images, isFavorite: Prodectse.isFavorite) )
      }
      
    }
    if arrSeleced.count != 0 {
    label.text = arrSeleced[0].info
      let imageView = SDAnimatedImageView()
      let animatedImage = SDAnimatedImage(named: "Loader1")
      imageView.image = animatedImage
      
    image.sd_setImage(with: URL(string: arrSeleced[0].image), placeholderImage: imageView.image)
    }else {
      label.text = "NONE"
    }
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
