//
//  LocationsViewController.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 8/19/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import MapKit

class LocationsViewController: UIViewController, MKMapViewDelegate, LocationCollectionDelegate, CLLocationManagerDelegate, TripJsonDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationCollectionVc: CollectionViewController!
    let center = CLLocation(latitude: 43.105304, longitude: -89.046729)
    var sites = Site.getSites()
    
    // use this var
    //var parser: JsonParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        loadPins()
        centerMapOnLocation(center)
        mapView.showsUserLocation = true
        
        // use this
        //parser = JsonParser(withDelegate: self, locations: sites)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // setting up the delegate
        locationCollectionVc = childViewControllers.first as! CollectionViewController
        locationCollectionVc.delegate = self
    }
    
    
    // use this func to get data and set it
    func getTripData(_ objects: [TripObject]) {
    
    }
    
    func loadPins(){
        let sites = Site.getSites()
        for site in sites {
            let annotation = Pin(lat: site.lat.value!, long: site.lon.value!)
            annotation.title = site.title
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let customAnnotation = annotation as? Pin {
            // How the pin itself is going to look
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //Shows title and detail button when user clicks on the pin
            pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            // Color of the pin
            pin.pinTintColor = customAnnotation.newPinColor()
            pin.animatesDrop = true
            pin.canShowCallout = true
            return pin
        }
        return nil
    }
    
    // centers the map on a specific point
    func centerMapOnLocation(_ location : CLLocation){
        let span = MKCoordinateSpanMake(2.0, 2.0)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // when an annotation is selected map pans into that certain point
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pin = view.annotation
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: pin!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.performSegue(withIdentifier: "details", sender: view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //         Get the new view controller using segue.destinationViewController.
        
        if (segue.identifier == "details" ){
            // segue into DetailViewController and pass through the slected pin's MKPinAnnotaion
            let blank = segue.destination as! DetailViewController
            blank.viaSegue = sender as! MKPinAnnotationView
        }
    }
    
    func cellTapped(withSite site: Site) {
        for pin in mapView.annotations {
            if pin.title! == site.title {
                mapView.selectAnnotation(pin, animated: true)
            }
        }
    }

}
