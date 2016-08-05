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
//        refHandle = ref.observeEventType(FIRDataEventType.Value,
//        withBlock: {(snapshot) in
//            let dataDict = snapshot.value as! [String:AnyObject]
//    
//        })
        
        let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEventOfType(.Value,
        withBlock:{(snapshot) in
            let name = snapshot.value!["Name"] as! String
            self.helloLabel.text = "Hello, \(name)"
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ViewProfileButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("ProfileView", sender: self)
    
        
    }
    
    @IBAction func JoggingClassButtonPressed(sender: AnyObject) {
        fetchClassInfoFromDatabase("35108005")
        
    }
    
    @IBAction func YogaClassButtonPressed(sender: AnyObject) {
        fetchClassInfoFromDatabase("49977071")
    }
    
    @IBAction func GolfClassButtonPressed(sender: AnyObject) {
        fetchClassInfoFromDatabase("91852603")
    }
    
    func fetchClassInfoFromDatabase(eventKey : String){
        
        ref.child("Classes").child(eventKey).observeSingleEventOfType(.Value,
        withBlock:{(snapshot) in
        classInfoVar.classProfileTitle = snapshot.value!["ClassTitle"] as! String
        classInfoVar.classProfileDescription = snapshot.value!["ClassDescription"] as! String
        classInfoVar.classProfileImageURL = snapshot.value!["ClassImage"] as! String
        classInfoVar.classProfileAddress = snapshot.value!["ClassAddress"] as! String
        classInfoVar.classProfilePrice = snapshot.value!["ClassPrice"] as! String
            
        self.goToClassInfoPage()
        })
        
    }
    
    func goToClassInfoPage() {
        self.performSegueWithIdentifier("HomeToClassInfo", sender: self)
    }
    
}
