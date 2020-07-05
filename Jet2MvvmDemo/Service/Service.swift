//
//  Service.swift
//  Jet2MvvmDemo
//
//  Created by Ankush on 03/07/20.
//  Copyright © 2020 Ankush. All rights reserved.
//

import Foundation
import UIKit

class Service: NSObject {
    
    static let shared = Service()
    
    func fetchCourses(pageNumber : String , completion: @escaping ([Articles]?, Error?) -> ()) {
        
        let urlString = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(pageNumber)&limit=10"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Articles].self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }

}
