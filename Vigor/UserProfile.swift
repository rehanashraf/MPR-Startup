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

class UserProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!

    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    var base64String: NSString!
    
    
    
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
            
        self.Name.text = name
        self.Email.text = email
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
        
        
    }
    
    

}
