//
//  HomeViewController.swift
//  Vigor
//
//  Created by pratham on 7/14/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {

    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    

    @IBOutlet weak var helloLabel: UILabel!
    
    
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
            self.helloLabel.text = "Hello, \(name)"
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ViewProfileButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("ProfileView", sender: self)
        
        
        
        
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
