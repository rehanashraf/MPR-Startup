//
//  SignInViewController.swift
//  Vigor
//
//  Created by pratham on 7/12/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate  {
    var ref: FIRDatabaseReference!

    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    @IBOutlet weak var tick1: UIImageView!
    @IBOutlet weak var tick2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()

        changeUIColor(UserName)
        changeUIColor(Password)
        
         UserName.delegate = self
         Password.delegate = self
        
    }
    
    func changeUIColor(myTextField :UITextField){
        myTextField.layer.borderColor = UIColor.whiteColor().CGColor
        myTextField.layer.borderWidth = 1.5
        myTextField.layer.cornerRadius = 4.0
        if let placeholder = myTextField.placeholder {
            myTextField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func LoginButtonPressed(sender: AnyObject) {
        
        FIRAuth.auth()?.signInWithEmail(self.UserName.text!, password: self.Password.text!) { (user, error) in
            if error == nil
            {
                self.tick1.image = UIImage(named: "Checked")
                self.tick2.image = UIImage(named: "Checked")
                self.tick1.hidden=true
                self.tick2.hidden=true
                
                self.UserName.text = ""
                self.Password.text = ""
                
                self.Login()
            }
            else
            {


                let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
                self.tick1.image = UIImage(named: "Delete")
                self.tick2.image = UIImage(named: "Delete")
                
                self.tick1.hidden=false
                self.tick2.hidden=false

            }
        }
        
    }
    func Login(){
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEventOfType(.Value,
                                                                  withBlock:{(snapshot) in
        let name = snapshot.value!["Name"] as! String
        let email = snapshot.value!["Email"] as! String
        let imgurl =  snapshot.value!["ProfilePicture"] as! String
                                                                    
                                                                    
                                                                    
        userOne.Name = name
        userOne.Email = email
        userOne.imageUrl = imgurl
           
        userOne.userPrint()
            })
        
        performSegueWithIdentifier("homeView", sender: nil)
                                                                    
        
    }
    
    

}

