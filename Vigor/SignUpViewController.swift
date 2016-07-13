//
//  SignUpViewController.swift
//  Vigor
//
//  Created by pratham on 7/13/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var RePassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeUIColor(Name)
        changeUIColor(Email)
        changeUIColor(Password)
        changeUIColor(RePassword)
        
        Name.delegate = self
        Email.delegate = self
        Password.delegate = self
        RePassword.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}
