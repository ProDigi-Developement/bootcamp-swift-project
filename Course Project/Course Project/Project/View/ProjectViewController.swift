//
//  ProjectViewController.swift
//  Course Project
//
//  Created by Alfredo Fernandes on 2017-12-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

public class ProjectViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        ProjectController.sharedInstance.fetchListInfo(onSuccess: onSuccessScenario, onFail: onFailScenario)
    }
    
    private func onSuccessScenario() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func onFailScenario(errorMessage: String) {
        print(errorMessage)
    }
}


extension ProjectViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProjectController.sharedInstance.list.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let person = ProjectController.sharedInstance.list[indexPath.row]
        
        let projectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectCollectionViewCell
        
        projectCell.lblCell.text = person.fullName()
        
        projectCell.imageCell.image(fromUrl: person.pictureUrl!)
        projectCell.imageCell.layer.cornerRadius = 60
        projectCell.imageCell.layer.masksToBounds = true
        
        return projectCell
    }
    
}


extension ProjectViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let person = ProjectController.sharedInstance.list[indexPath.row]

        let alertController = UIAlertController(title: "Person \(person.firstName)", message: "You selected \(person.fullName())\n His/Her e-mail is \(person.email)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler:nil)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}


extension UIImageView {
    
    public func image(fromUrl urlString: String) {
        
        guard let url = URL(string: urlString) else {
            print("Couldn't create URL from \(urlString)")
            return
        }
        
        let theTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: response)
                }
            }
        }
        theTask.resume()
    }
}
