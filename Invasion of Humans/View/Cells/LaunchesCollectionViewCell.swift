//
//  LaunchesCollectionViewCell.swift
//  Invasion of Humans
//
//  Created by Recep Bayraktar on 01.05.2021.
//

import UIKit
import Kingfisher

class LaunchesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Cell Outlets
    @IBOutlet weak var missionPatchLogo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var launchNumber: UILabel!
    
    //MARK: - Cell Data Loading from API
    func loadData(data: Launch) {
        missionPatchLogo.kf.indicatorType = .activity
        let imageURL = URL(string: data.links?.patch?.small ?? "")
        missionPatchLogo.kf.setImage(with: imageURL)
        nameLabel.text = data.name
        launchNumber.text = "Flight Number: \(data.flight_number ?? 00000)"
    }    
}
