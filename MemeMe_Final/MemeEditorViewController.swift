//
//  MemeEditorViewController.swift
//  MemeMe_Final
//
//  Created by Mehdi Salemi on 2/12/16.
//  Copyright © 2016 MxMd. All rights reserved.
//  View Controller for the Meme Editing

import UIKit

class MemeEditorViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    // Mark : Meme
    var meme : Meme!
    var currentlyEditing: Int!
    
    // MARK :  Items
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    //Mark : Buttons
    var shareButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    var cameraButton = UIBarButtonItem()
    var albumButton = UIBarButtonItem()
    
    @IBAction func shareImage(sender: AnyObject){
        save()
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(controller, animated:  true, completion:  nil)
    }
    
    @IBAction func cancel(sender: AnyObject){
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeTabBarController") as! UITabBarController
        navigationController?.presentViewController(detailController, animated: true,completion:nil)
    }
    
    @IBAction func cameraImage(sender: AnyObject) {
        createImagePicker(true)
    }
    
    @IBAction func albumImage(sender: AnyObject) {
        createImagePicker(false)
    }
    
    func createImagePicker(fromCamera : Bool){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if fromCamera {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.allowsEditing = false
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let selectedImage : UIImage = image
        imagePickerView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
        topTextField.hidden = false
        bottomTextField.hidden = false
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    // Mark : View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareImage:")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel:")
        
        if meme == nil {
            setTextField("TOP", textField: topTextField)
            setTextField("BOTTOM", textField: bottomTextField)
            
            albumButton = UIBarButtonItem(title: "Album", style: .Done, target: self, action: "albumImage:")
            cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraImage:")
            currentlyEditing = -1
        } else {
            imagePickerView.image = meme.image
            setTextField(meme.topText, textField: topTextField)
            setTextField(meme.bottomText, textField: bottomTextField)
        }
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        imagePickerView.contentMode = .ScaleAspectFit

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        navigationController?.setToolbarHidden(false, animated: true)
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem = shareButton
        toolbarItems = [cameraButton,albumButton]
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setTextField(text:String, textField:UITextField) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.orangeColor(),
            NSFontAttributeName : UIFont(name: "TrebuchetMS", size: 40)!,
            NSStrokeWidthAttributeName : -5
        ]
        
        textField.backgroundColor = UIColor.clearColor()
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.text = text
        textField.delegate = self
        
    }
    
    // Mark : Keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    // MARK: Saving/Generating
    func save() {
        
        if imagePickerView.image == nil {
            let alert = UIAlertController()
            alert.title = "Please add and image!"
            let okAction = UIAlertAction(title: "Ok.", style: UIAlertActionStyle.Default) {
                action in self.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        if currentlyEditing == -1 {
            meme = Meme(top:topTextField.text!, bottom:bottomTextField.text!, original:imagePickerView.image!, meme: generateMemedImage())
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
            print("New Meme Saved")
        } else {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes[currentlyEditing] = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imagePickerView.image!, meme: generateMemedImage())
            print("Meme Edit Successfull!")
        }
    }
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memeImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memeImage
    }

}

