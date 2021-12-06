//
//  ViewController.swift
//  MapTestStart
//
//  Created by 羅壽之 on 2021/11/26.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let centerLocation = CLLocationCoordinate2D(latitude: 40.689247, longitude: -74.044502)
    let zoomSize = 500.0
    var currentHeading = 0.0
    
    @IBOutlet var rotateButton: UIButton!
    @IBOutlet var myMap: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
    }
    
    func initRegion() {
        // set the visible region (MKCoordinateRegion)
        let region = MKCoordinateRegion(center:centerLocation, latitudinalMeters: zoomSize, longitudinalMeters: zoomSize)
        myMap.setRegion(region, animated: false)
        rotateButton.isHidden = true
    }
    
    func initCamera() {
        // set the camera viewpoint (MKMapCamera)
        let camera = MKMapCamera(lookingAtCenter: centerLocation, fromDistance: 100,pitch: 50.0, heading: currentHeading)
        myMap.setCamera(camera, animated: true)
        rotateButton.isHidden = false
    }
    
    func initMap() {
        // set the region or camera viewpoint
        if myMap.mapType != .satelliteFlyover {
            initRegion()
        }
        else {
            initCamera()
        }
        
        // set the annotation (MKPointAnnotation)
        let annotation = MKPointAnnotation()
        annotation.title = "state of liberty"
        annotation.subtitle = "new york"
        annotation.coordinate = centerLocation
        myMap.addAnnotation(annotation)
        
    }
    
    @IBAction func rotate(_ sender: Any) {
        currentHeading = (currentHeading + 30).remainder(dividingBy: 360.0)
        let myCamera = MKMapCamera(lookingAtCenter: centerLocation, fromDistance: 100, pitch: 50.0, heading: currentHeading)
        myMap.setCamera(myCamera, animated: true)
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: //standard
            myMap.mapType = .standard
            initRegion()
        case 1: //satellite
            myMap.mapType = .satellite
            initRegion()
        case 2: //flyover
            myMap.mapType = .satelliteFlyover
            initCamera()
        default:
            break
        }
    }


}

