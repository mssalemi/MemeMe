//
//  MemeDetailViewController.swift
//  MemeMe_Final
//
//  Created by Mehdi Salemi on 2/12/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    var meme : Meme!
    var currentMeme: Int!
    
    var editButton:UIBarButtonItem!
    var deleteButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "editMeme:")
        deleteButton = UIBarButtonItem(title: "Delete", style: .Done, target: self, action: "deleteMeme:")
        
        self.navigationItem.rightBarButtonItems = [editButton,deleteButton]
        
        self.image.image = meme.memedImage
    }
    
    @IBAction func editMeme(sender: AnyObject){
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        detailController.meme   = meme
        detailController.currentlyEditing = currentMeme
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func deleteMeme(sender: AnyObject){
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(currentMeme)
        print("Meme Delete Successfull!")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
