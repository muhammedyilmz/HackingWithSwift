//
//  DetailViewController.swift
//  Project1
//
//  Created by Muhammed Yılmaz on 26.10.2024.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage : String?
    var selectedPictureNumber = 0
    var totalPictureNumber = 0
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "This image is \(selectedPictureNumber + 1)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
