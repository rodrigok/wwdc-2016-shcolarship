//
//  MapViewController.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 25/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigationBar: UINavigationBar!

    var lat :CLLocationDegrees = 0.0
    var lng :CLLocationDegrees = 0.0
    var delta :CLLocationDegrees = 20

    @IBAction func closeButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func setCoord (lat: CLLocationDegrees, lng: CLLocationDegrees, delta: CLLocationDegrees = 20) {
        self.lat = lat
        self.lng = lng
        self.delta = delta
    }
    
    func setMapPin (lat: CLLocationDegrees, lng: CLLocationDegrees, delta: CLLocationDegrees = 20) {
        let coord = CLLocationCoordinate2DMake(lat, lng)
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = coord
        self.mapView.addAnnotation(dropPin)
        
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let region = MKCoordinateRegion(center: coord, span: span)
        
        mapView.setRegion(region, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setMapPin(lat, lng: lng, delta: delta)
        
        self.navigationBar.topItem?.title = self.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
