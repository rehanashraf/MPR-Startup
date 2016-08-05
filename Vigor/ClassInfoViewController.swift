//
//  ClassInfoViewController.swift
//  Vigor
//
//  Created by pratham on 8/3/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class ClassInfoViewController: UIViewController,UINavigationControllerDelegate{
    
    @IBOutlet weak var ClassProfilePic: UIImageView!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var ClassButton: UIButton!
    @IBOutlet weak var ClassDesc: UITextView!
    
    var refHandle: UInt!
    var base64String: NSString!
    let imageCache = NSCache()
    var imageURL = classInfoVar.classProfileImageURL
    
    override func viewDidLoad() {
        
    ClassLabel.text = classInfoVar.classProfileTitle
    ClassDesc.text = classInfoVar.classProfileDescription
        
        
    
    
        
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL("gs://vigor-eaf6d.appspot.com")
        let imageRef = storageRef.child(imageURL)
        
        
        
        
        
        
        if let cachedImage = self.imageCache.objectForKey(imageURL) as? UIImage{
            
            self.ClassProfilePic.image = cachedImage
            return
        }
        
        
        imageRef.dataWithMaxSize(6144*6144*6144*6144*6144) { (data, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let profileImage = UIImage(data: data!){
                    self.imageCache.setObject(profileImage, forKey: self.imageURL)
                    self.ClassProfilePic.image = profileImage
                }
            }
        }
    
    
    }
    
    @IBAction func BackButtonPressed(sender: AnyObject) {
        
 self.performSegueWithIdentifier("ClassInfoToHome", sender: self)
    }
}