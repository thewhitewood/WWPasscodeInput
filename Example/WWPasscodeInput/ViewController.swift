//
//  ViewController.swift
//  WWPasscodeInput
//
//  Created by nick@thewhitewood.com on 10/03/2018.
//  Copyright (c) 2018 nick@thewhitewood.com. All rights reserved.
//

import UIKit
import WWPasscodeInput

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let passcodeField = WWPasscodeInput()
        view.addSubview(passcodeField)
        
        passcodeField.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: passcodeField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let verticalConstraint = NSLayoutConstraint(item: passcodeField, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        
        view.addConstraints([horizontalConstraint, verticalConstraint])
        
        passcodeField.passcodeLimit = 6
        passcodeField.markerColour = UIColor.black.withAlphaComponent(0.2)
        passcodeField.completedMarkerColour = .black
        
        passcodeField.becomeFirstResponder()
    }

}

