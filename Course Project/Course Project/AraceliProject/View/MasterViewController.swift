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
        
    }
}

extension MasterViewController: MKMapViewDelegate {

}
