//
//  ShippingAddressVC.swift
//  finshdproject
//
//  Created by Yousef Albalawi on 28/05/1443 AH.
//

import UIKit
import MapKit
import CoreLocation

class ShippingAddressVC: UIViewController ,
                         CLLocationManagerDelegate {
  
  
  // MARK: - Properties
  
  var manger = CLLocationManager()
  
  
  // MARK: -IBOutlet
  
  @IBOutlet weak var mapView: MKMapView!
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    manger.desiredAccuracy = kCLLocationAccuracyBest
    manger.delegate = self
    manger.requestWhenInUseAuthorization()
    manger.startUpdatingLocation()
  }
  
  
  // MARK: - IBAction
  
  @IBAction func ciusBT(_ sender: Any) {
    
    dismiss(animated: true,
            completion: nil);
  }
  
  
  @IBAction func selectionButtonPreased(_ sender: UIButton) {
    
    let latitude = manger.location!.coordinate.latitude
    
    let longitude = manger.location!.coordinate.longitude
    NotificationCenter.default.post(name: Notification.Name("shippingAddress"),
                                    object: nil,
                                    userInfo: ["latitude":Double(latitude), "longitude":Double(longitude)])
    ciusBT("")
  }
  
  
  // MARK: - functions
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    
    if let location = locations.first {
      
      manger.accuracyAuthorization
      render(location)
    }
  }
  
  
  func render (_ location:CLLocation) {
    
    let span = MKCoordinateSpan(latitudeDelta: 0.1,
                                longitudeDelta: 0.1)
    
    let Coordinat = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                           longitude: location.coordinate.longitude)
    
    let rehion = MKCoordinateRegion (center: Coordinat,
                                     span: span)
    mapView.setRegion(rehion,
                      animated: true)
    
    let pin = MKPointAnnotation ()
    pin.coordinate = Coordinat
    mapView.addAnnotation(pin)
  }
}
