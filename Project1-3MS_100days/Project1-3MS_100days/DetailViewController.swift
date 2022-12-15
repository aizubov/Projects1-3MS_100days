//
//  DetailViewController.swift
//  Project1-3MS_100days
//
//  Created by user226947 on 12/14/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var countryselected: Int?
    var picturesHR: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard picturesHR != nil else {
            print("No flag found!")
            return
        }
        
        if let countrytoshow = countryselected {
            title = countryCodes[picturesHR![countryselected!].split(separator: "_")[2].split(separator: ".")[0].uppercased(), default: "No country found!"]
            imageView.image = UIImage(named: picturesHR![countrytoshow])
            
        }
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }

    
    @objc func shareFlag() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found!")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [title ?? "No country found!", image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }}
