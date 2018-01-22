//
//  MainViewController.swift
//  Course Project
//
//  Created by Yash Patel on 2018-01-19.
//  Copyright © 2018 ProDigi. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    

    let cellReuseIdentifier:String = "personCell"

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        PersonZipController.sharedInstance.fetchListInfo(onSuccess: onSuccessScenario, onFail: onFailScenario)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func onSuccessScenario() {
        DispatchQueue.main.async {
            //self.collectionView.reloadData()
            self.tableview.reloadData()
        }
    }
    
    private func onFailScenario(errorMessage: String) {
        print(errorMessage)
    }
    
}

extension TopViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonZipController.sharedInstance.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TopViewTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TopViewTableViewCell
        cell.personName.text = PersonZipController.sharedInstance.list[indexPath.row].fullName()
        
        
        
    
        cell.personImage.image(fromUrl: PersonZipController.sharedInstance.list[indexPath.row].pictureUrl!)
        
        cell.personImage.layer.shadowColor = UIColor.black.cgColor
        cell.personImage.layer.shadowOpacity = 0.3
        cell.personImage.layer.shadowOffset = CGSize.zero
        cell.personImage.layer.shadowRadius = 10
        cell.personImage.layer.shouldRasterize = true

        return cell
    }
    
    
}

extension TopViewController:UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Working")
        let person = PersonZipController.sharedInstance.list[indexPath.row]

        let detailView: DetailTopViewController = storyboard?.instantiateViewController(withIdentifier: "passtodetailscreen") as! DetailTopViewController
        
        detailView.person = person
        
        self.navigationController?.present(detailView, animated: true, completion: nil)
    }

}


