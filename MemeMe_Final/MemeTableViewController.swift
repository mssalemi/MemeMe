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
    
    
    //Mark : Meme
    var memes: [Meme]!
    
    func updateMemes(){
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    //Mark : Buttons
    var plusButton = UIBarButtonItem()
    var editButton = UIBarButtonItem()
    
    @IBAction func newMeme(sender: AnyObject){
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    // Mark : View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newMeme:")
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")
        
        self.navigationItem.hidesBackButton = true
        updateMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateMemes()
        self.navigationItem.rightBarButtonItem = plusButton
        self.tableView.reloadData() // Reload Data so if a delete was done to get the new data.
    }
    
    // Mark : Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("tableViewCell")!
        
        let meme = self.memes[indexPath.row]
        cell.textLabel?.text = meme.topText! + "-" + meme.bottomText!
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme   = self.memes[indexPath.row]
        detailController.currentMeme = indexPath.row
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = memes[fromIndexPath.row]
        memes.removeAtIndex(fromIndexPath.row)
        memes.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
//    func anotherMeme(){
//        self.dismissViewControllerAnimated(true, completion: nil)
//        self.performSegueWithIdentifier("anotherMeme", sender: self)
//        
//    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
//    //For deleting the Meme
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        memes.removeAtIndex(indexPath.row)
//        
//        applicationDelegate.memes = memes
//        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
//    
//    func edit(){
//        self.editing = !self.editing
//    }
    
    

}
