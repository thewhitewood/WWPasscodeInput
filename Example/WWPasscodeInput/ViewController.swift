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

        let horizontalConstraint = NSLayoutConstraint(item: passcodeField, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)

        let verticalConstraint = NSLayoutConstraint(item: passcodeField, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)

        view.addConstraints([horizontalConstraint, verticalConstraint])

        passcodeField.passcodeLimit = 6
        passcodeField.markerColour = UIColor.black.withAlphaComponent(0.2)
        passcodeField.completedMarkerColour = .black
        passcodeField.markerRadius = 5
    }
}
