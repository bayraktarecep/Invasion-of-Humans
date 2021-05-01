//
//  LaunchesViewModel.swift
//  Invasion of Humans
//
//  Created by Recep Bayraktar on 01.05.2021.
//

import Foundation

class LaunchesViewModel {
    
    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    var launches: [Launch] = []
    
    func fetchData() {
        
        let request = URLRequest(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let response = try decoder.decode([Launch].self, from: data)
                            self.onSuccessResponse?()
                            self.launches = response
                        } catch let error {
                            self.onErrorResponse?("Not a Valid JSON Response with Error : \(error)")
                            print(error)
                        }
                    } else {
                        self.onErrorResponse?("HTTP Status: \(response.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
}
