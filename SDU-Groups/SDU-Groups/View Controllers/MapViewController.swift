//
//  MapViewController.swift
//  SDU-Groups
//
//  Created by Simone Christensen on 05/10/2019.
//  Copyright © 2019 Borgar Bordoy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController  {
    
    /*
     SDU's location - rookie mistake, use comma
     Latitude = 55,368963
     Longitude = 10;428282
     */
    
 
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 400
    
    // alert button for not enabled gps
    //let gpsNotEnabled = UIAlertController(title: "Location not found", message: "To use this function go to settings and enable gps.", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()

        // Do any additional setup after loading the view.
        
        }
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //Checks whether or not if user has enabled location in mobile settings
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            
        } else {
            print("User must enable gps in settings")
            //self.present(gpsNotEnabled, animated: true, completion: nil)
            
            
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        // If user allows use of location
        case .authorizedWhenInUse:
            // Do Map Stuff
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            print("ShowUserLocation is set to true")
            break
        //If user denies use of location
        case .denied:
            // Show alert instructing them how to turn on permissions
            print("Denied")
            break
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            print("Not determined")
            break
        case .restricted:
            // Show in alert letting them know what's up
            print("Restricted")
            break
        case .authorizedAlways:
            print("Authorized always")
            break
        default:
            print("Default")
            break
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        print("Location = \(locValue.latitude) \(locValue.longitude)")
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}
  

