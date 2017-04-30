//
//  ViewController.swift
//  PokeFinder
//
//  Created by Anthony Washington on 4/20/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var mapCentered = false
    private var geoFire: GeoFire!
    private var geoFireRef: FIRDatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        geoFireRef = FIRDatabase.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
    }
    
    // request location when view loads
    override func viewDidAppear(_ animated: Bool) { locationStatus() }
    
    // tracks if user changes location authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    // Center map when app first loads
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let location = userLocation.location {
            if !mapCentered {
                centerMap(location: location)
                mapCentered = true
            }
        }
    }
    
    // Set custom annotation (instead of blue dot for user location)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view : MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self) {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: "user")
            view?.image = UIImage(named: "ash")
        }
        
        return view
    }
    
    
    func locationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // Zoom map in to user location
    func centerMap(location: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(region, animated: true)
    
    }

    
    // set pokemon at location
    func createSighting(forLocation location: CLLocation, withPokemon pokeId: Int) {
        geoFire.setLocation(location, forKey: "\(pokeId)")
    }

    @IBAction func spotRandom(_ sender: Any) {
    }

}

