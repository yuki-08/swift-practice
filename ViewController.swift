//
//  ViewController.swift
//  MyMap2
//
//  Created by yuki_takahashi on 2018/12/19.
//  Copyright © 2018 qawse Labs. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputText.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let serchkeyword = textField.text
        
        print(serchkeyword!)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(serchkeyword!, completionHandler: { (placemarks:[CLPlacemark]?, error:Error?) in
            if let placemark = placemarks?[0] {
                if let targetCoordinate = placemark.location?.coordinate {
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCoordinate
                    pin.title = serchkeyword
                    
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region = MKCoordinateRegion.init(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                }
            }
        })
        
        return true
    }
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var displayMap: MKMapView!
}

