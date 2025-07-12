//
//  APICalls.swift
//  DispatchGroupSampleSwift
//
//  Created by Mantosh Kumar on 11/07/25.
//

import UIKit

// Define the model
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class APICalls {
    
    // Function to make a network call
    func fetchPost(id: Int, completion: @escaping (Post?) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(id)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL for id: \(id)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error for post \(id): \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data for post \(id)")
                completion(nil)
                return
            }
            
            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(post)
            } catch {
                print("Decoding failed for post \(id): \(error)")
                completion(nil)
            }
        }.resume()
    }
}


