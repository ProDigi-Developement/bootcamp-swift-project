//
//  MasterViewController.swift
//  Course Project
//
//  Created by Araceli Teixeira on 15/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit
import MapKit

class MasterViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var mapItems: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        UserController.sharedInstance.fetchUserList(onSuccess: onSuccessScenario, onFail: onFailScenario)
    }
    
    private func onSuccessScenario() {
        DispatchQueue.main.async {
            self.placeUsers(UserController.sharedInstance.userList)
        }
    }
    
    private func onFailScenario(errorMessage: String) {
        print(errorMessage)
    }
    
    private func placeUsers(_ list:[User]) {
        let request = MKLocalSearchRequest()
        for user in list {
            request.naturalLanguageQuery = user.fullAddress()
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start { (response, error) -> Void in
                if response == nil {
                    let alertController = UIAlertController(title: nil, message: user.fullName() + " address not found", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.title = user.fullName()
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: response!.boundingRegion.center.latitude, longitude:     response!.boundingRegion.center.longitude)
                
                let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
                self.mapView.centerCoordinate = pointAnnotation.coordinate
                self.mapView.addAnnotation(pinAnnotationView.annotation!)
            }
        }
    }
}

extension MasterViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "marker"
        
        if #available(iOS 11.0, *) {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView
            
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                view?.annotation = annotation
            }
            return view
        } else {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView
            
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                view?.annotation = annotation
            }
            return view
        }
    }
}
