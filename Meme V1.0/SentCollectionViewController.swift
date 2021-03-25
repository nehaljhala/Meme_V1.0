//
//  SentCollectionViewController.swift
//  Meme V1.0
//
//  Created by Nehal Jhala on 2/25/21.
//

import UIKit
import Foundation
import Photos

class SentCollectionViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    var assetCollection: PHAssetCollection!
    var photoAsset: PHFetchResult<PHAsset>!
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print (appDelegate.memes.count)
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        print (dimension)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: 400, height: 400)
        let fetchOptions = PHFetchOptions()
        self.photoAsset = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
//        print (appDelegate.memes.count)
        
        collectionView!.reloadData()
    }
    
    // MARK: Collection View Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes.count
        //return self.appDelegate.memes.count
//        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meme.MemesCollectionViewCell", for: indexPath) as! MemesCollectionViewCell
//        let asset: PHAsset = self.photoAsset[indexPath.item]
//        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: nil, resultHandler: {(result, inof)in
//            if result != nil {
//                cell.MemesImageView.image = result
//            }
//        })
//        return cell

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meme.MemesCollectionViewCell", for: indexPath) as! MemesCollectionViewCell
        let memeForCell = memes[indexPath.row]
//        let memes = self.appDelegate.memes[(indexPath as NSIndexPath).row]

        // Set the name and image
        cell.MemesImageView.image = memeForCell.memedImage
        print("entering cellforitemat4")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        //        let editView = self.storyboard!.instantiateViewController(withIdentifier: "CreateNewMemeViewController") as! ViewController
        //        //editView = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        //        self.navigationController!.pushViewController(editView, animated: true)
        //        collectionView.reloadData()
        //        print("after new in collectionview")
    }
    
    
}

