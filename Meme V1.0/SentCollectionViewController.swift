//
//  SentCollectionViewController.swift
//  Meme V1.0
//  Created by Nehal Jhala on 2/25/21.


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let space:CGFloat = 3.0
        let w = (view.frame.size.width - (2 * space)) / 3.0
        let h = (view.frame.size.height - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: w, height: w)
        print(flowLayout.itemSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        collectionView!.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Collection View Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meme.MemesCollectionViewCell", for: indexPath) as! MemesCollectionViewCell
        let memeForCell = memes[indexPath.row]
        cell.MemesImageView.image = memeForCell.memedImage
        print("entering cellforitemat4")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(identifier: "MemesDetailViewController") as!MemesDetailViewController
        detailController.m_image = memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
}

