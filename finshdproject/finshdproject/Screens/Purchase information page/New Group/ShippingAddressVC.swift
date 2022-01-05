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

  
 var manger = CLLocationManager()
  
  @IBOutlet weak var mapView: MKMapView!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    manger.desiredAccuracy = kCLLocationAccuracyBest
    manger.delegate = self
    manger.requestWhenInUseAuthorization()
    manger.startUpdatingLocation()
  }

  @IBAction func cius(_ sender: Any) {
    dismiss(animated: true, completion: nil);
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
    manger.accuracyAuthorization
   
    render(location)
  }
}
  func render (_ location:CLLocation) {
   
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let Coordinat = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    let rehion = MKCoordinateRegion (center: Coordinat,
                                     span: span)
    mapView.setRegion(rehion, animated: true)
    
    let pin = MKPointAnnotation ()
    pin.coordinate = Coordinat
    mapView.addAnnotation(pin)
  }
}
