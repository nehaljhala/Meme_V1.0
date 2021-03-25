//
//  TableViewController.swift
//  Meme V1.0
//
//  Created by Nehal Jhala on 3/21/21.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {
    
    @IBAction func buttonForMeme(_ sender: Any) {
    }

    
    var memes:[Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tableviewcell is loading")
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesTableViewCell") as! MemesTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage;
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetailViewController") as! MemesDetailViewController
//        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
//        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
