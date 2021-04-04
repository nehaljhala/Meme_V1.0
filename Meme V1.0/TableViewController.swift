//  TableViewController.swift
//  Meme V1.0
//  Created by Nehal Jhala on 3/21/21.


import UIKit
import Foundation

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesTableViewCell") as! MemesTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage;
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]! {
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tableviewcell is loading")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetailViewController") as! MemesDetailViewController
        detailController.m_image = memes[indexPath.row].memedImage
        print(indexPath)
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}




