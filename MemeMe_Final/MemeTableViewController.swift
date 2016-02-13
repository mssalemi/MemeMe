//
//  MemeTableViewController.swift
//  MemeMe_Final
//
//  Created by Mehdi Salemi on 2/12/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {

    var memes: [Meme]!
    
    func updateMemes(){
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    var plusButton = UIBarButtonItem()
    var editButton = UIBarButtonItem()
    
    @IBAction func newMeme(sender: AnyObject){
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newMeme:")
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
        
        navigationItem.hidesBackButton = true
        updateMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateMemes()
        navigationItem.rightBarButtonItem = plusButton
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("tableViewCell")!
        
        let meme = memes[indexPath.row]
        cell.textLabel?.text = meme.topText! + "-" + meme.bottomText!
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme   = memes[indexPath.row]
        detailController.currentMeme = indexPath.row
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = memes[fromIndexPath.row]
        memes.removeAtIndex(fromIndexPath.row)
        memes.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    

}
