//
//  LaunchDetailsViewController.swift
//  Invasion of Humans
//
//  Created by Recep Bayraktar on 01.05.2021.
//

import UIKit
import Kingfisher
import SafariServices

class LaunchDetailsViewController: UIViewController {
    
    //MARK: - Details Outlets
    var launchDetails: Launch?
    
    @IBOutlet weak var missionPatchLogo: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var wikButton: UIButton!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Button Enable Check
        if launchDetails?.links?.webcast == nil {
            self.youtube.isEnabled = false
        } else {
            self.youtube.isEnabled = true
        }
        
        if launchDetails?.links?.wikipedia == nil {
            self.wikButton.isEnabled = false
        } else {
            self.wikButton.isEnabled = true
        }
        //MARK: - Detail Data Loads
        loadDetails()
        //MARK: - Navigation Bar Title Prepare
        self.navigationItem.title = launchDetails?.name
    }
    
    //MARK: - Detail page loading from API
    func loadDetails(){
        guard let launchesDetails = launchDetails else { return }
        
        missionPatchLogo.kf.indicatorType = .activity
        missionPatchLogo.kf.setImage(with: URL(string: launchesDetails.links?.patch?.large ?? ""))
        
        if launchesDetails.success == false {
            self.statusLabel.text = "Failed"
            self.statusLabel.textColor = .red
        } else if launchesDetails.success == true {
            self.statusLabel.text = "Success"
            self.statusLabel.textColor = .green
        }else if launchesDetails.success == nil {
            self.statusLabel.text = "Not Launched"
            self.statusLabel.textColor = .yellow
        }
        self.detailsLabel.text = launchesDetails.details ?? "There is no details for this launch. You can still check above it from Wikipedia or YouTube if available."
        
    }
    //MARK: - YouTube Button to Watch Launch
    @IBAction func youtubeLink(_ sender: Any) {
        let url = URL(string: launchDetails?.links?.webcast ?? "")
        let config = SFSafariViewController.Configuration()
        let vc = SFSafariViewController(url: url!, configuration: config)
        present(vc, animated: true)
    }
    
    //MARK: - Wikipedia Button for Reading
    @IBAction func Wikipedia(_ sender: Any) {
        let url = URL(string: launchDetails?.links?.wikipedia ?? "")
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url!, configuration: config)
        present(vc, animated: true)
    }
    
}
