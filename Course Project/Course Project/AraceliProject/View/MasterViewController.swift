//
//  MasterViewController.swift
//  Course Project
//
//  Created by Araceli Teixeira on 15/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

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
        for user in list {
            let annotation = UserPointAnnotation(user)
            let coordinate = RandomLocationGenerator.generateCoordinates()
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
            annotations.append(annotation)
        }
        mapView.showAnnotations(self.annotations, animated: true)
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
            userAnnotation.subtitle = userAnnotation.user.address
            let iconView: UIImageView = UIImageView(image: userAnnotation.user.icon)
            view?.leftCalloutAccessoryView = iconView
            view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.infoLight)
            view?.canShowCallout = true
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? UserPointAnnotation else {
            return
        }
        
        let alert = UIAlertController(title: annotation.user.fullName(), message: configureMessage(annotation.user), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureMessage(_ user: User) -> String {
        return "\(user.email)\n\(user.address), \(user.country)"
    }
}
