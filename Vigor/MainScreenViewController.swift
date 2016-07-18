//
//  MainScreenViewController.swift
//  Vigor
//
//  Created by pratham on 7/12/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(loginButton)
//        loginButton.center = view.center
//        loginButton.delegate = self
        

        if let token = FBSDKAccessToken.currentAccessToken() {
//            fetchProfile()
            performSegueWithIdentifier("FBHomeView", sender: nil)
            print("in view did load")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Facebook Login Completed")
        print(result.token.tokenString) //YOUR FB TOKEN
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: result.token.tokenString, version: nil, HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil)
            {
                print("result \(result)")
            }
            else
            {
                print("error \(error)")
            }
        })
        performSegueWithIdentifier("FBHomeView", sender: nil)
 //       fetchProfile()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func fetchProfile()
    {
        print("Current profile Fetched")
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil{
                print("printing error",error)
                return
            }
            if let email = result ["email"] as? String {    // prathi here is the email we can use this to store in the database.
                
                print("Email is ",email, ".")
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String{
                print("The url where the picture is at ", url)
            }
        }
    }
    @IBAction func loginFacebookAction(sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                }
            })
        }
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
