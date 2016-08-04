//
//  ClassInfoViewController.swift
//  Vigor
//
//  Created by pratham on 8/3/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit

class ClassInfoViewController: UIViewController {
    
    @IBOutlet weak var ClassProfilePic: UIImageView!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var ClassDesc: UILabel!
    @IBOutlet weak var ClassButton: UIButton!
    
    override func viewDidLoad() {
        
        ClassLabel.text = classInfoVar.classProfileTitle
        ClassDesc.text = classInfoVar.classProfileDescription
        
    }
    

}
