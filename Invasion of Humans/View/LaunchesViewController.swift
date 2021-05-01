//
//  LaunchesViewController.swift
//  Invasion of Humans
//
//  Created by Recep Bayraktar on 01.05.2021.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = LaunchesViewModel()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Navigation Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(sort))
        //MARK: - Loading Data from API
        loadData()
    }
    
    //MARK: - Sort by Year ActivitySheet
    @objc func sort() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sortDesc = UIAlertAction(title: "Sort By Year Descending", style: .default, handler: { [weak self] _  in
            guard let self = self else { return }
            
            
            let sorted = self.viewModel.launches.sorted { (first, second) -> Bool in
                first.date_utc.prefix(4) > second.date_utc.prefix(4)
            }
            self.viewModel.launches = sorted
            self.collectionView.reloadData()
        })
        
        let sortAsc =  UIAlertAction(title: "Sort By Year Ascending", style: .default, handler: { [weak self] _  in
            guard let self = self else { return }
            
            let sorted = self.viewModel.launches.sorted { (first, second) -> Bool in
                first.date_utc.prefix(4) < second.date_utc.prefix(4)
            }
            self.viewModel.launches = sorted
            self.collectionView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(sortDesc)
        actionSheet.addAction(sortAsc)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    //MARK: - Get data from Api
    func loadData() {
        viewModel.onErrorResponse = { error in
            self.showAlert(message: error)
        }
        viewModel.onSuccessResponse = {
            self.collectionView.reloadData()
        }
        viewModel.fetchData()
    }
    
    //MARK: - Error Alert Response
    func showAlert(title: String = "Something Wrong", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - CollectionView DataSource and Delegate Extension
extension LaunchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LaunchesCollectionViewCell
        //MARK: - Cell Settings for Radius and Shadow
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        //MARK: - Cell data loading
        cell.loadData(data: viewModel.launches[indexPath.row])
        
        return cell
    }
    //MARK: - Fetch Data to Details Page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "details") as? LaunchDetailsViewController
        vc?.launchDetails = viewModel.launches[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
