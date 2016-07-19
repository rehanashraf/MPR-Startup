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

class UserProfile: UIViewController {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

}
