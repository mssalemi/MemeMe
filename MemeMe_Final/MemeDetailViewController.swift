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
        
        navigationItem.rightBarButtonItems = [editButton,deleteButton]
        
        image.image = meme.memedImage
        
        image.contentMode = .ScaleAspectFit
        
    }
    
    @IBAction func editMeme(sender: AnyObject){
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        detailController.meme   = meme
        detailController.currentlyEditing = currentMeme
        
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func deleteMeme(sender: AnyObject){
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(currentMeme)
        print("Meme Delete Successfull!")
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeTabBarController") as! UITabBarController
        navigationController?.presentViewController(detailController, animated: true,completion:nil)
    }
    
    
}
