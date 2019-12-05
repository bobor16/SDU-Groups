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

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class MapViewController: UIViewController, MKMapViewDelegate {
    
    /*
     SDU's location - rookie mistake, use comma
     Latitude = 55,368963
     Longitude = 10;428282
     */
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 400
    
    let latitude: CLLocationDegrees = 55.368963
    let longitude: CLLocationDegrees = 10.428282
    
    // alert button for not enabled gps
    //let gpsNotEnabled = UIAlertController(title: "Location not found", message: "To use this function go to settings and enable gps.", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        checkLocationServices()
        //        openMapForPlace()
        let location = CLLocationCoordinate2D(latitude: 55.368963, longitude:10.428282)
        let location2 = CLLocationCoordinate2D(latitude: 56.368963, longitude:11.428282)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
        
        let pin = customPin(pinTitle: "Room U172", pinSubTitle: "Building 44", location: location)
        self.mapView.addAnnotation(pin)
        self.mapView.delegate = self
        
        let pin2 = customPin(pinTitle: "Honory Dalailama Temple", pinSubTitle: "Dharamshala, Himachal Pradesh, India", location: location2)
        self.mapView.addAnnotation(pin2)
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        let annotationView2 = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"pin")
        annotationView2.image = UIImage(named:"pin2")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation title == \(String(describing: view.annotation?.title!))")
    }
    
    func openMapForPlace() {
        
        let regionDistance:CLLocationDistance = 400
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Your Location"
        mapItem.openInMaps(launchOptions: options)
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
