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
    private var annotations: [MKAnnotation] = []
    
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
        var count = 0
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
                
                let annotation = UserPointAnnotation(user)
                annotation.coordinate = CLLocationCoordinate2D(latitude: response!.boundingRegion.center.latitude, longitude: response!.boundingRegion.center.longitude)
                
                self.annotations.append(annotation)
                
                count += 1
                if count == list.count {
                    self.mapView.showAnnotations(self.annotations, animated: true)
                }
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
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            view?.annotation = annotation
        }
        
        if let userAnnotation = annotation as? UserPointAnnotation {
            userAnnotation.title = userAnnotation.user.fullName()
            userAnnotation.subtitle = userAnnotation.user.fullAddress()
            let iconView: UIImageView = UIImageView(image: userAnnotation.user.icon)
            view?.leftCalloutAccessoryView = iconView
            view?.canShowCallout = true
        }
        return view
        
    }
}
