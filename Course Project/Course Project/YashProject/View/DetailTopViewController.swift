//
//  DetailTopViewController.swift
//  Course Project
//
//  Created by Yash Patel on 2018-01-21.
//  Copyright © 2018 ProDigi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailTopViewController: UIViewController {

    public var person: PersonZip? = nil
    
    @IBOutlet weak var personMap: MKMapView!
    @IBOutlet weak var personLargeImg: UIImageView!
    @IBOutlet weak var personFullName: UILabel!
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mailButton(_ sender: UIButton) {
        
        setAlert(getAlertMsg: (person?.email)!, getTitle: "Mail")
        
    }
    
    @IBAction func callButton(_ sender: UIButton) {
        setAlert(getAlertMsg: (person?.cell)!, getTitle: "Call")
    }
    
    
    @IBAction func msgButton(_ sender: UIButton) {
        setAlert(getAlertMsg: (person?.cell)!, getTitle: "Message")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setImage()
        setLabel()
        getLocation(address: (self.person?.city.uppercased())!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setImage()
    {
        personLargeImg.image(fromUrl: (person?.pictureUrl)!)
        personLargeImg.layer.cornerRadius = 60
        personLargeImg.layer.cornerRadius = personLargeImg.bounds.width/2
        personLargeImg.layer.masksToBounds = true
        personLargeImg.layer.borderWidth = 3
        personLargeImg.layer.borderColor = UIColor.white.cgColor
    }
    
    func setLabel()
    {
        personFullName.text = String("  " + (person?.fullName())! + "    ")
        personFullName.layer.cornerRadius = 10
        personFullName.layer.masksToBounds = true
        personFullName.layer.backgroundColor = UIColor.white.cgColor
    }
    
    func setAlert( getAlertMsg : String, getTitle : String)
    {
        let alertPop = UIAlertController.init(title: getTitle, message: getAlertMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler:nil)
        alertPop.addAction(okAction)
        self.present(alertPop, animated: true, completion: nil)
    }
    
    fileprivate func getLocation(address: String) {
        let geocoder = CLGeocoder()
        
        // Find city
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            
            // Add Pin
            
        
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, lon!)
            let span: MKCoordinateSpan = MKCoordinateSpanMake(10, 10)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.personMap.setRegion(region, animated: true)
            
            // Add Annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = address
            self.personMap.addAnnotation(annotation)
        }
    }
}
