//
//  SentCollectionViewController.swift
//  Meme V1.0
//
//  Created by Nehal Jhala on 2/25/21.
//

import UIKit

class SentCollectionViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
