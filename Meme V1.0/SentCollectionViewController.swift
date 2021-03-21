//
//  SentCollectionViewController.swift
//  Meme V1.0
//
//  Created by Nehal Jhala on 2/25/21.
//

import UIKit
import Foundation

class SentCollectionViewController:UICollectionViewController {
      
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        print("memes count: \(self.memes.count)")
        return appDelegate.memes
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("collection view controller viewdidload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        self.tabBarController?.tabBar.isHidden = false
        print ("collection view controller viewwillappear")
        collectionView!.reloadData()
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print (memes.count)
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemesCollectionViewCell", for: indexPath) as! MemesCollectionViewCell
        let memes = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.MemesImageView?.image = memes.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetailViewController") as! MemesDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
