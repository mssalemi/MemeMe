//
//  Meme.swift
//  MemeMe_Final
//
//  Created by Mehdi Salemi on 2/12/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import Foundation
import UIKit

struct Meme{
    var topText:String!
    var bottomText:String!
    var image: UIImage!
    var memedImage: UIImage!
    
    init(top:String, bottom:String, original:UIImage, meme:UIImage){
        topText = top
        bottomText = bottom
        image = original
        memedImage = meme
    }
}