//
//  SignUpViewController.swift
//  Vigor
//
//  Created by pratham on 7/13/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    //All the TextFields
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var RePassword: UITextField!
    
    //Checkmarks on the side
    @IBOutlet weak var tick1: UIImageView!
    @IBOutlet weak var tick2: UIImageView!
    @IBOutlet weak var tick3: UIImageView!
    @IBOutlet weak var tick4: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Forgmat the textfield UI
        changeUIColor(Name)
        changeUIColor(Email)
        changeUIColor(Password)
        changeUIColor(RePassword)
        
        //Return/keyboard goes away when touched outside of the text field
        Name.delegate = self
        Email.delegate = self
        Password.delegate = self
        RePassword.delegate = self
        
    //Sets a Target every single time textfield is changed
//    Name.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
//    Email.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
//    Password.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
//    RePassword.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    
    @IBAction func SignUpButtonClicked(sender: AnyObject) {
        
        //set Images dynamically
        tick1.image = UIImage(named: "Delete")
        tick2.image = UIImage(named: "Delete")
        tick3.image = UIImage(named: "Delete")
        tick4.image = UIImage(named: "Delete")
        
        //checks if the user enter information correctly
        if(isTextFieldEmpty(Name.text!)){
            tick1.hidden=false
        }
        else if(isTextFieldEmpty(Name.text!)==false){
            tick1.image = UIImage(named: "Checked")
            tick1.hidden=false
        }
        if(isTextFieldEmpty(Email.text!)){
            tick2.hidden=false
        }
        else if(isTextFieldEmpty(Email.text!)==false){
            tick2.image = UIImage(named: "Checked")
            tick2.hidden=false
        }
        if(isTextFieldEmpty(Password.text!)){
            tick3.hidden=false
        }
        else if(isTextFieldEmpty(Password.text!)==false){
            tick3.image = UIImage(named: "Checked")
            tick3.hidden=false
        }
        if(isTextFieldEmpty(RePassword.text!)){
            tick4.hidden=false
        }
        else if(isTextFieldEmpty(RePassword.text!)==false){
            tick4.hidden=true
        }
        if(RePassword.text != Password.text){
            RePassword.text = nil
            RePassword.placeholder = "Passwords Don't Match!"
            tick4.hidden=false
        }
        else if (RePassword.text == Password.text && RePassword.text != "" && Password != ""){
             tick3.image = UIImage(named: "Checked")
             tick4.image = UIImage(named: "Checked")
             tick3.hidden = false
             tick4.hidden = false
        }
        
        
        
    }
    //returns a Boolean Value if the text field is empty
    func isTextFieldEmpty(input : String) -> Bool{
        
        if(input == "" || input == " "){
            return true
        }
        else{
             return false
        }
    }
    
    //Triggers this function every single time user enters something into the textfield
//    func textFieldDidChange(textField: UITextField) {
//        
//    }
    
    //Changes the color of the UITextField
    func changeUIColor(myTextField :UITextField){
        myTextField.layer.borderColor = UIColor.whiteColor().CGColor
        myTextField.layer.borderWidth = 1.5
        myTextField.layer.cornerRadius = 4.0
        if let placeholder = myTextField.placeholder {
            myTextField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        }
        
    }
    //Kills the keyboard if the return button is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Kills the keboard if a touch outside of the textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
