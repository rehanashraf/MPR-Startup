//
//  UserProfile.swift
//  Vigor
//
//  Created by pratham on 7/18/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class UserProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!

    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    var base64String: NSString!
    
    let imageCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicture.layer.cornerRadius = 16
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        
        ref = FIRDatabase.database().reference()
        refHandle = ref.observeEventType(FIRDataEventType.Value,
        withBlock: {(snapshot) in
        let dataDict = snapshot.value as! [String:AnyObject]
        print(dataDict)
        })
        
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEventOfType(.Value,
        withBlock:{(snapshot) in
        let name = snapshot.value!["Name"] as! String
        let email = snapshot.value!["Email"] as! String
        let imageURL = snapshot.value!["ProfilePicture"] as! String
        print(imageURL)
                  
        self.Name.text = name
        self.Email.text = email
            
        let storage = FIRStorage.storage()
        
        let storageRef = storage.referenceForURL("gs://vigor-eaf6d.appspot.com")
         
        let islandRef = storageRef.child(imageURL)
        
            if let cachedImage = self.imageCache.objectForKey(imageURL) as? UIImage{
                
                self.profilePicture.image = cachedImage
                return
            }
        
            islandRef.dataWithMaxSize(6144*6144*6144*6144*6144) { (data, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    print("Not CACHE")
                    if let islandImage = UIImage(data: data!){
                    self.imageCache.setObject(islandImage, forKey: imageURL)
                    self.profilePicture.image = islandImage
                        
                    print(self.imageCache)
                        
                        
                    }
                    
                }
            }
            
            
            
        })
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func BackButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("ProfileToHome", sender: self)
    }
    
    @IBAction func SignOut(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.performSegueWithIdentifier("logOut", sender: nil)
    }
    
    @IBAction func EditButtonPressed(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        presentViewController(picker, animated: true, completion: nil)
        picker.delegate = self
        picker.allowsEditing = true
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
         var selectedImageFromPicker: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            profilePicture.image = selectedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
        let imageName = NSUUID().UUIDString
        
        let storageRef = FIRStorage.storage().reference().child("\(imageName)")
            
            if let uploadData = UIImagePNGRepresentation(self.profilePicture.image!) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    if let user = FIRAuth.auth()?.currentUser
                    {
                    let userID : String = user.uid

                    if let ProfileImageURL = metadata?.downloadURL()?.absoluteString{
                        self.ref.child("Users").child(userID).updateChildValues(["ProfilePicture" : imageName ])
                        
                      }
                    }
                    
                })
                
                
          }
        
        
        
    }
    
    @IBAction func TOSClicked(sender: AnyObject) {
        if let url = NSURL(string: "http://www.google.com"){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func privacyPolicyClicked(sender: AnyObject) {
        if let url = NSURL(string: "http://www.google.com"){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func AboutClicked(sender: AnyObject) {
        if let url = NSURL(string: "http://www.google.com"){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    

}
