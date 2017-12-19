//
//  DetailViewController.swift
//  Course Project
//
//  Created by Alfredo Fernandes on 2017-12-15.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var imgBackgound: UIImageView!
    
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var mapDetail: MKMapView!
    
    public var person: Project? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if person != nil {
            
            // Image
            imgDetail.image(fromUrl: self.person!.pictureUrl!)
            imgDetail.layer.cornerRadius = imgDetail.bounds.width/2
            imgDetail.layer.masksToBounds = true
            imgDetail.layer.borderWidth = 3;
            imgDetail.layer.borderColor = UIColor.white.cgColor
            
            // Full Name
            lblFullName.text = self.person?.fullName()
            lblLocation.text = self.person?.cityState()
            
            // Coordinates
            getLocation(address: (self.person?.city.uppercased())!)
        }
        
    }
    
    @IBAction func closeDetail(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnMessageTapped(_ sender: UIButton) {
        sendMessage(self.person!.cell)
    }
    
    @IBAction func btnCallTapped(_ sender: UIButton) {
        callNumber(self.person!.cell)
    }
    
    @IBAction func btnMailTapped(_ sender: UIButton) {
        sendMail(self.person!.email)
    }
    
    
    fileprivate func sendMessage(_ phoneNumber: String) {
        if let url = URL(string: "sms:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
    fileprivate func callNumber(_ phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(url)) {
                application.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    fileprivate func sendMail(_ email: String) {
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
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
            self.mapDetail.setRegion(region, animated: true)
            
            // Add Annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = address
            self.mapDetail.addAnnotation(annotation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
