//
//  MemesDetailViewController.swift
//  Meme V1.0
//  Created by Nehal Jhala on 4/3/21.


import UIKit

class MemesDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView:UIImageView!
    
    var m_image:UIImage = UIImage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        imageView.image = m_image
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
}
