//
//  ViewController.swift
//  DispatchGroupSampleSwift
//
//  Created by Mantosh Kumar on 11/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var apiCalls = APICalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callMultiplePosts()
    }
    
    private func callMultiplePosts() {
        
        DispatchQueue.main.async {
            self.statusLabel.text = "Stated API calls..."
        }
        
        let dispatchGroup = DispatchGroup()
        
        for i in 1...5 {
            dispatchGroup.enter()
            apiCalls.fetchPost(id: i) { post in
                if let post = post {
                    print("Post \(i) Title: \(post.title)")
                } else {
                    print("Failed to fetch post \(i)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print(" Done, All API calls completed")
            self.statusLabel.text = "Done all API calls..."

        }
    }
    
    
}






