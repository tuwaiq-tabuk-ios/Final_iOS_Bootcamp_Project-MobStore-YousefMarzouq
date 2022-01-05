//
//  firrViewController.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 19/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage


class UploadProcutsFirebseVC: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var label: UILabel!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
//    imageView.image = UIImage(named: "loge")
    
    let storage = Storage.storage()
    let storageImage = storage.reference(forURL: "https://firebasestorage.googleapis.com:443/v0/b/sirisupportapp.appspot.com/o/E0D0F636-60A3-4AD7-81AA-C689704DE163%2FD5DED7C3-D2C3-448A-913E-71402145B35D?alt=media&token=db77e129-b5bb-43a0-a9e7-824b67e822e7")
    // Download the data, assuming a max size of 1MB (you can change this as necessary)
    storageImage.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
      // Create a UIImage, add it to the array
      self.imageView.image = UIImage(data: data!)
      print("~~ storageImage \(storageImage)")
    }
    
//    for prod in arr2 {
//      saveData(Prodect: prod) { Bool in
//        if Bool {
//          print("~~ done")
//        } else {
//          print("~~ error")
//        }
//      }
//    }
        
    }
    

  @IBAction func openCamara(_ sender: UIButton) {
   // let sto
  }
 
//
//  func saveData(Prodect: Prodects , completion: @escaping (Bool) -> ()) {
//
//      let db = Firestore.firestore()
//      let storage = Storage.storage()
//    let documentID = UUID().uuidString
//
//      var documentIDimage = ""
//
//      if documentIDimage == "" {
//        documentIDimage = UUID().uuidString
//      }
//
//
//
//      var imageCafeConverted:[Data] = [Data]()
//
//      for image in Prodect.images {
//        guard let imageCafePhoto = image.jpegData(compressionQuality: 0.5) else {
//          print("Error: could not convert")
//          return completion(false)
//        }
//        imageCafeConverted.append(imageCafePhoto)
//      }
//
//
//      let uploadMetadata = StorageMetadata()
//      uploadMetadata.contentType = "image/jpeg"
//
//
//      var imageCafeConvertedURL = [String]()
//
//      for data in imageCafeConverted {
//          documentIDimage = UUID().uuidString
//
//        let storageRef = storage.reference().child(documentID).child(documentIDimage)
//
//        storageRef.putData(data , metadata: uploadMetadata) { metadata , error in
//          guard error == nil else {
//            print("😡 ERROR: upload for ref \(storageRef) failed. \(error!.localizedDescription)")
//            return
//          }
//
//
//          storageRef.downloadURL { url, error in
//            guard error == nil else {
//              print("😡 ERROR: Get url for ref \(storageRef) failed. \(error!.localizedDescription)")
//              return
//          }
//            imageCafeConvertedURL.append(url!.absoluteString)
//          }
//
//       }
//        }
//
//      guard let imagePhoto = Prodect.image.jpegData(compressionQuality: 0.5) else {
//        print("Error: could not convert")
//        return completion(false)
//      }
//
//      documentIDimage = UUID().uuidString
//      let storageRefPhoto = storage.reference().child(documentID).child(documentIDimage)
//      var imagePhotoURl:String!
//
//      storageRefPhoto.putData(imagePhoto , metadata: uploadMetadata) { metadata , error in
//        guard error == nil else {
//          print("😡 ERROR: upload for ref \(storageRefPhoto) failed. \(error!.localizedDescription)")
//          return
//        }
//
//        storageRefPhoto.downloadURL { url, error in
//          guard error == nil else {
//            print("😡 ERROR: Get url for ref \(storageRefPhoto) failed. \(error!.localizedDescription)")
//            return
//        }
//          imagePhotoURl = url!.absoluteString
//
//        }
//
//      }
//
//      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(60)) {
//        db.collection("Prodects").document(documentID).setData([
//        "image":imagePhotoURl as String,
//        "info":Prodect.info as String,
//        "price":Prodect.price as Double,
//        "brand":Prodect.brand as String,
//        "type":Prodect.type as String,
//        "Offers":Prodect.Offers as Bool,
//        "images":imageCafeConvertedURL as Array,
//        "isFavorite":Prodect.isFavorite as Bool,
//      ]) {
//        (error) in
//
//        if error != nil {
//          print("Error: \(error!.localizedDescription)")
//        } else {
//
//        }
//
//      }
//      }
//
//
//      completion(true)
//    }

}




//  let arr2:[Prodects] = [
//
//   //   Aple Brandd Add new
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "12mini")!,
//            info: "Apple-12 mini-128",
//            price: 6500,
//            brand: "Apple",
//            type: "Phone",
//            Offers: true,
//            images: [UIImage(named: "12mini")!,
//                     UIImage(named:"12mini")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "12promax")!,
//            info: "Apple-12promax-128",
//            price: 3500,brand: "Apple", type: "Phone", Offers: false, images: [UIImage(named: "12promax")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024581_apple-ipad-pro-129-inch-wi-fi-512-gb-silver")!,
//            info: "Apple pro-129-inch-wi-fi-512-gb-silver",
//            price: 599,brand: "Apple", type: "Tablet", Offers: true, images: [UIImage(named: "0024581_apple-ipad-pro-129-inch-wi-fi-512-gb-silver")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "Gold")!,
//            info: "Apple-11 Promax-128",
//            price: 599,brand: "Apple", type: "Phone", Offers: false, images: [UIImage(named: "Gold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "iPhone11-Black-1")!,
//            info: "Apple-11-128",
//            price: 599,brand: "Apple", type: "Phone", Offers: false, images: [UIImage(named: "iPhone11-Black-1")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "iPhone13-Starlight")!,
//            info: "Apple- 13 -128",
//            price: 599,brand: "Apple", type: "Phone", Offers: false, images: [UIImage(named: "iPhone13-Starlight")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "iPhone13Pro-Graphite")!,
//            info: "Apple- 13 -128",
//            price: 599,brand: "Apple", type: "Phone", Offers: false, images: [UIImage(named: "iPhone13Pro-Graphite")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "iPhone13Pro-Sierra-blue")!,
//            info: "Apple- 13Pro -128",
//            price: 599,brand: "Apple", type: "Phone", Offers: false, images: [UIImage(named: "iPhone13Pro-Sierra-blue")!], isFavorite: false),
//
//   // Apple Accessories
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0023639_appleiphone-13-pro-clear-case-with-magsafe")!,
//            info: "appleiphone 13pro clear case with magsafe",
//            price: 599,brand: "Apple", type: "Accessories", Offers: true, images: [UIImage(named: "0023639_appleiphone-13-pro-clear-case-with-magsafe")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0023648_apple-iphone-13-pro-max-leather-case-with-magsafe-golden-brown")!,
//            info: "appleiphone13promax leather casewith",
//            price: 599,brand: "Apple", type: "Accessories", Offers: false, images: [UIImage(named: "0023648_apple-iphone-13-pro-max-leather-case-with-magsafe-golden-brown")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0023651_apple-iphone-13-pro-max-leather-case-with-magsafe-midnight")!,
//            info: "appleiphone13promax leather with",
//            price: 599,brand: "Apple", type: "Accessories", Offers: true, images: [UIImage(named: "0023651_apple-iphone-13-pro-max-leather-case-with-magsafe-midnight")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024379_apple-lightning-to-usb-cable-2-m-md819zma")!,
//            info: "Apple- lightning cable ",
//            price: 599,brand: "Apple", type: "Accessories", Offers: false, images:  [UIImage(named: "0024379_apple-lightning-to-usb-cable-2-m-md819zma")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "Daco_5921962")!,
//            info: "Apple- Airbods ",
//            price: 599,brand: "Apple", type: "Accessories", Offers: true, images: [UIImage(named: "0024379_apple-lightning-to-usb-cable-2-m-md819zma")!], isFavorite: false),
//
//
//
//
//
//   //   Samsung Brandd Add new
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "foold")!,
//            info: "Samsung-foold-128",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0018319_samsung-galaxy-s21-ultra-5g-256-gb-12-gb-ram-phantom-silver")!,
//            info: "Samsung-s21-ultra128",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0018360_samsung-galaxy-s21-plus-5g-128-gb-8-gb-ram-phantom-black_510")!,
//            info: "Samsung-s21-plus128",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0018778_samsung-galaxy-a12-dual-sim-lte-64-64-gb-blue_510")!,
//            info: "Samsung-a12-64gb",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0019381_samsung-galaxy-a02-32-gb-red")!,
//            info: "Samsung-a12-32gb",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0021140_samsung-galaxy-a32-dual-sim-4g-64-128-gb-black")!,
//            info: "Samsung-a32-128gb",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images:[UIImage(named: "foold")!], isFavorite: false),
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0021158_samsung-galaxy-a22-dual-sim-5g-66-128-gb-white_510")!,
//            info: "Samsung-a22-128",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0021158_samsung-galaxy-a22-dual-sim-5g-66-128-gb-white_510")!,
//            info: "Samsung-a22-128",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0021335_samsung-25w-fast-wall-charger-ta-only-black")!,
//            info: "Samsung-25w-charger",
//            price: 3500,brand: "Samsung", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0021941_samsung-flip-cover-with-pen-or-z-fold-xxx-black")!,
//            info: "Samsung cover foldwith-pen",
//            price: 3500,brand: "Samsung", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0022247_samsung-galaxy-a03s-32-gb-4g-blue")!,
//            info: "Samsung-a03s-32",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0022310_samsung-galaxy-a52s-dual-sim-5g-65-128-gb-ram-8-gb-awesome-mint")!,
//            info: "Samsung-a52s-128",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024305_samsung-galaxy-tab-s7-fe-124-5g-64gb4gb-mystic-silver")!,
//            info: "Samsung-tab s7-128 5g ",
//            price: 3500,brand: "Samsung", type: "Tablet", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024591_samsung-galaxy-tab-a7-lite-87-lte-32gb-silver_510")!,
//            info: "Samsung-tab a7- 32gb ",
//            price: 3500,brand: "Samsung", type: "Tablet", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "BTS-eShop450x450-1")!,
//            info: "Samsung-tabs7-128 5g ",
//            price: 3500,brand: "Samsung", type: "Tablet", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024337_samsung-galaxy-z-flip3-256gb-5g-8gb-ram-lavender_510")!,
//            info: "Samsung zflip3 256gb 5g 8gbram ",
//            price: 3500,brand: "Samsung", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//
//   //   Honar Brandd Add new
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024111_honor-50-dual-5g-256-gb-ram-8-gb-frost-crystal")!,
//            info: " honor50 dual 5g 256gb ram8 frostcrystal ",
//            price: 3500,brand: "Honor", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024124_honor-50-dual-5g-256-gb-ram-8-gb-emerald-green_510")!,
//            info: " honor50 dual 5g 256gb ram8 emeraldgreen ",
//            price: 3500,brand: "Honor", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024663_honor-50-lite-dual-4g-128-gb-ram-8-gb-midnight-black")!,
//            info: " honor50lite dual4g 128gb ram8 midnightblack ",
//            price: 3500,brand: "Honor", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024680_honor-50-lite-dual-4g-128-gb-ram-8-gb-space-silver")!,
//            info: "honor50lite dual4g 128gb ram8 pacesilver ",
//            price: 3500,brand: "Honor", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//
//   //   Lenovo Brandd Add new
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0023267_lenovo-tablet-tab-m10-hd-tb-x505x-101-inch-2gb-ram-32gb-4g-lte-slate-black")!,
//            info: "Samsung-foold-128",
//            price: 499,brand: "lenovo", type: "Tablet", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//
//   //   Huawei Brandd Add new
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0025002_huawei-y5p-dual-4g-32gb-ram-2gb-midnight-black_510")!,
//            info: "huawei-y5p-32gb",
//            price: 3500,brand: "Huawei", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0022154_huawei-nova-8-4g-128gb-8gb-ram-blush-gold_510")!,
//            info: "huaweinova9 4g 128gb 8gbram blushgold ",
//            price: 3500,brand: "Huawei", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024645_huawei-nova-9-4g-128gb-8gb-ram-starry-blue")!,
//            info: "huaweinova9 4g 128gb 8gbram starryblue",
//            price: 3500,brand: "Huawei", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0016365_huawei-matepad-t8-lte-ram-2-gb-16-gb-blue_510")!,
//            info: "huawei-matepad t8lte ram2gb 16gbblue",
//            price: 3500,brand: "Huawei", type: "Tablet", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024646_huawei-nova-9-4g-128gb-8gb-ram-black")!,
//            info: " huaweinova9 4g 128gb 8gbram black ",
//            price: 3500,brand: "Huawei", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//
//   // Vivo
//
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0019033_vivo-y12s-32-gb-4g-phantom-black_510")!,
//            info: "vivo y12s 32gb 4g phantomblack",
//            price: 3500,brand: "Vivo", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0020650_vivo-x60-pro-256-gb-ram-12gb-5g-blue_510")!,
//            info: " vivo x60pro 256gb ram12gb 5g blue ",
//            price: 3500,brand: "Vivo", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0020665_vivo-y72-128gb-ram-8gb-5g-dream-glow_510")!,
//            info: "vivo y72 128gb ram8gb 5g dreamglow",
//            price: 3500,brand: "Vivo", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0022063_vivo-v21-128gb-ram-8gb-5g-dusk-blue_510")!,
//            info: " vivo v21 128gb ram8gb 5g dusk-blue ",
//            price: 3500,brand: "Vivo", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024381_vivo-y21-64-gb-ram-4gb-metallic-blue_510")!,
//            info: " vivo y21 64gb ram4gb metallic-blue ",
//            price: 3500,brand: "Vivo", type: "Phone", Offers: true, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0024596_vivo-y33s-dual-sim-128-gb-ram-8-gb-4g-mirror-black_510")!,
//            info: " vivoy33s dualsim 128gb ram8gb4g mirror-black ",
//            price: 3500,brand: "Vivo", type: "Phone", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//
//
//   //  all  Accessories
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0002159_anker-powercore-10050-mah-quick-charge-30-power-bank-silver")!,
//            info: "power bank anker 10050mah",
//            price: 149,brand: "anker", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0002492_anker-5200mah-astro-e1-ultra-compact-portable-charger-white")!,
//            info: "power bank anker 5200mah",
//            price: 79,brand: "anker", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0003350_anker-powerdrive-2-ports-24w-with-3ft-micro-usb-cable-black")!,
//            info: "ports anker 24w ",
//            price: 79,brand: "anker", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0003412_anker-powerdrive-elite-2-ports-car-charger-with-lightning-connector-un-white")!,
//            info: "ports anker 24w with lightning",
//            price: 149,brand: "anker", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0003934_adata-premier-64gb-microsdhcsdxc-uhs-i-u1-memory-card-with-adapter")!,
//            info: " SD 64 ",
//            price: 49,brand: "adata", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0004541_popsockets-collapsible-grip-stand-for-phones-and-tablets-ghost-marble")!,
//            info: "popsockets stand ",
//            price: 29,brand: "popsockets", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0004886_huawei-power-bank-6700-mah-with-quick-charge-cp07-black")!,
//            info: "bank power 6700 huawei",
//            price: 79,brand: "Huawei", type: "Accessories", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0005801_popsockets-collapsible-grip-stand-for-phones-and-tablets-pink-donut")!,
//            info: "popsockets stand",
//            price: 29,brand: "popsockets", type: "Accessories", Offers: false, images:[UIImage(named: "foold")!], isFavorite: false),
//
//   //  all  card
//
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013549_mobily-data-recharge-300-gb-3-months")!,
//            info: "mobily data recharge 300gb 3months ",
//            price: 29,brand: "mobily", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013563_zain-internet-recharge-card-300gb-3-months")!,
//            info: "zain internet recharge card 300gb 3months",
//            price: 29,brand: "zain", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013569_lebara-data-10-gb-for-3month")!,
//            info: "lebara data 10gb for 3month",
//            price: 29,brand: "lebara", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013576_itunes-gift-card-10-us-store")!,
//            info: "itunes gift card 10us store",
//            price: 29,brand: "itunes", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013581_itunes-gift-card-50-us-store")!,
//            info: "itunes gift card 50us store",
//            price: 29,brand: "itunes", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013582_itunes-gift-card-60-us-store")!,
//            info: "itunes gift card 60us store",
//            price: 29,brand: "itunes", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013585_itunes-gift-card-150-us-store")!,
//            info: "itunes gift card 150us store",
//            price: 29,brand: "itunes", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013589_itunes-gift-card-500-us-store")!,
//            info: "itunes gift card 500us store",
//            price: 29,brand: "itunes", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013597_playstation-network-50-psn-card-saudi-store")!,
//            info: "playstation network 50psn card saudi store",
//            price: 29,brand: "playstation", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013625_microsoft-xbox-live-sar-300-saudi-store")!,
//            info: "microsoft xbox live sar 300 saudi store",
//            price: 29,brand: "xbox", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//    Prodects(id: UUID().uuidString, image:UIImage(named: "0013617_google-play-15-us-store")!,
//            info: "google play 15 us store",
//            price: 29,brand: "google", type: "CardGame", Offers: false, images: [UIImage(named: "foold")!], isFavorite: false),
//
//
//  ]
