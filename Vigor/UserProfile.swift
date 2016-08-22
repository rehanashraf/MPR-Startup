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
import FirebaseAuth

class UserProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    
        
    
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    var base64String: NSString!
    let imageCache = NSCache()
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
//        refHandle = ref.observeEventType(FIRDataEventType.Value,
//        withBlock: {(snapshot) in
//        let dataDict = snapshot.value as! [String:AnyObject]
//
//        })
        
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEventOfType(.Value,
        withBlock:{(snapshot) in
            
        let imageURL = userOne.imageUrl
           
                  
        self.Name.text = userOne.Name
        self.Email.text = userOne.Email
            
         self.Name.delegate = self
         self.Email.delegate = self

        
            
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL("gs://vigor-eaf6d.appspot.com")
        let imageRef = storageRef.child(imageURL)
        
            
            if let cachedImage = self.imageCache.objectForKey(imageURL) as? UIImage{
                
                self.profilePicture.image = cachedImage
                return
            }
            
        
            imageRef.dataWithMaxSize(6144*6144*6144*6144*6144) { (data, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    if let profileImage = UIImage(data: data!){
                    self.imageCache.setObject(profileImage, forKey: imageURL)
                    self.profilePicture.image = profileImage
                    }
                }
            }
        })
    }
    override func viewDidLayoutSubviews() {
        profilePicture.layer.borderWidth = 3
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
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
        userOne.userPrint()
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
                    userOne.imageUrl = imageName
                    let userID : String = user.uid

                    if (metadata?.downloadURL()?.absoluteString) != nil{
                        self.ref.child("Users").child(userID).updateChildValues(["ProfilePicture" : userOne.imageUrl ])
                        
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
    
    
    @IBAction func nameEditButtonPressed(sender: AnyObject) {
        print("heyman")
//        if(self.Name.text == "" || self.Name.text == " "){
//            Name.placeholder = "Please Enter a Name"
//        }
//        else{
//        let updatedName : String =  Name.text!
//        userOne.Name = updatedName
//        let user = FIRAuth.auth()?.currentUser
//        let userID : String = user!.uid
//        self.ref.child("Users").child(userID).updateChildValues(["Name" : userOne.Name ])
//        }
//        
        
    }
    
    @IBAction func emailEditButtonPressed(sender: AnyObject) {
        let user = FIRAuth.auth()?.currentUser
        let updatedEmail : String =  Email.text!

        
        if(self.Name.text == "" || self.Name.text == " "){
            Name.placeholder = "Please Enter a Valid Email"
         }
        else{
        user?.updateEmail(updatedEmail) { error in
            if let error = error {
                let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                let userID : String = user!.uid
                userOne.Email = updatedEmail
                userOne.userPrint()
                self.ref.child("Users").child(userID).updateChildValues(["Email" : userOne.Email ])       }
          }
        }
    }
    
    @IBAction func deleteAccountPressed(sender: AnyObject) {
        let user = FIRAuth.auth()?.currentUser
        let userID : String = user!.uid

        
        user?.deleteWithCompletion { error in
                if let error = error {
                    let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
               
            } else {
               
                print("User Deleted Sucessfully")

                self.ref.child("Users").child(userID).removeValue()
                self.performSegueWithIdentifier("logOut", sender: nil)

            
            }
        }
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Kills the keboard if a touch outside of the textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func BecomeAtrainerButtonPressed(sender: AnyObject) {
//        self.performSegueWithIdentifier("UserProfileToPayment", sender: nil)
    }
    func makeImageRounder(){
        profilePicture.layer.borderWidth = 3
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        
        
    }
    
    
}
