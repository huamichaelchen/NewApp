//
//  MainMapView.swift
//  NewApp
//
//  Created by Hua Chen on 2015-01-26.
//  Copyright (c) 2015 Hua Chen. All rights reserved.
//

import UIkit
import MapKit
import CoreLocation


class MainMapView: UIViewController, MKMapViewDelegate,
CLLocationManagerDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var profileContainerView: UIView!
  
  
  var locationManager = CLLocationManager()
  
  
  @IBAction func showProfileView(sender: UIBarButtonItem) {
    mapView.alpha = 0.5
    profileContainerView.hidden = false
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Core Location
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
   
    
    // Basic Map
    
    let location = CLLocationCoordinate2D(latitude: 45.091565,
      longitude: -64.362743)
    
    let span = MKCoordinateSpanMake(0.01, 0.01)
    let region = MKCoordinateRegion(center: location, span: span)
    mapView.setRegion(region, animated: true)
    
    let annotation = MKPointAnnotation()
    annotation.setCoordinate(location)
    annotation.title = "JustUs Cafe"
    annotation.subtitle = "Wolfville"
    mapView.addAnnotation(annotation)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func locationManager(manager:CLLocationManager,
    didUpdateLocations locations: [AnyObject]) {
      
      var userLocation:CLLocation = locations[0] as CLLocation
      
      let location = CLLocationCoordinate2D(
        latitude: userLocation.coordinate.latitude,
        longitude: userLocation.coordinate.longitude)
      let span = MKCoordinateSpanMake(0.01, 0.01)
      let region = MKCoordinateRegion(center: location, span: span)
      mapView.setRegion(region, animated: true)
      
      println("locations = \(locations)")
    
  }
  
  func locationManager(locationManager: CLLocationManager,
    didFailWithError error: NSError) {
      println(error)
  }
  


}
