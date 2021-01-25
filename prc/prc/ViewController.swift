//
//  ViewController.swift
//  prc
//
//  Created by user165337 on 1/24/21.
//  Copyright © 2021 user165337. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1st
        let latitude: CLLocationDegrees = 43.64
        let longtitude: CLLocationDegrees = -79.38
        
        //displaylocation
        displayLocation(latitude: latitude, longitude: longtitude, title: "Toronto", subtitle: "You are here")
        //
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongPressAnnotation))
        map.gestureRecognizerShouldBegin(uilpgr)
        
        //double tap
        addDoubleTap()
        
        
    }
    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTouchesRequired = 2
        map.addGestureRecognizer(doubleTap)
        
    }
    @objc func dropPin(sender:UITapGestureRecognizer){
        //
        let touchPoint = sender.location(in: map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom:map)
        let annotation = MKPointAnnotation()
        annotation.title = "My destination"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
    }
    //longpress annotation
    @objc func addLongPressAnnotation(gestureReconizer:UIGestureRecognizer){
        let touchpoint = gestureReconizer.location(in:map)
        let coordinate = map.convert(touchpoint,toCoordinateFrom:map)
        
        let annotation = MKPointAnnotation()
        annotation.title = "My favourite"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
    }
    
    // mark display location method
    func displayLocation(latitude:CLLocationDegrees,
                         longitude:CLLocationDegrees,
                         title:String,
                         subtitle:String){
        //2 of 1 span
        let latDelta:CLLocationDegrees = 0.05
        let lngDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        
        
        // definie location
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
         // region
        let region = MKCoordinateRegion(center: location, span: span)
        
        // automatic
        map.setRegion(region, animated: true)
        // anotation
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = location
        map.addAnnotation(annotation)
        
    }


}

