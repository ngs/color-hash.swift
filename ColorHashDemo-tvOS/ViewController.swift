//
//  ViewController.swift
//  ColorHashDemo-tvOS
//
//  Created by Atsushi Nagase on 12/13/15.
//  Copyright © 2015 LittleApps Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let color = ColorHash("Test", [0.4], [0.3]).color
        print(color)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

