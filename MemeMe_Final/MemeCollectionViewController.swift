//
//  MemeCollectionViewController.swift
//  MemeMe_Final
//
//  Created by Mehdi Salemi on 2/12/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    var memes: [Meme]!
    var plusButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newMeme:")
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = plusButton
        
        updateMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateMemes()
        collectionView?.reloadData()
    }
    
    
    func updateMemes(){
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    @IBAction func newMeme(sender: AnyObject){
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]

        cell.memeImageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme   = memes[indexPath.row]
        detailController.currentMeme = indexPath.row
        navigationController!.pushViewController(detailController, animated: true)
    }
    

    
}
