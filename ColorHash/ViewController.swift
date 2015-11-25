//
//  ViewController.swift
//  ColorHash
//
//  Created by Atsushi Nagase on 11/25/15.
//  Copyright © 2015 LittleApps Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var lightnessSlider: UISlider!
    @IBOutlet weak var saturationLabel: UILabel!
    @IBOutlet weak var lightnessLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let def = NSUserDefaults.standardUserDefaults()
        def.registerDefaults(["str": "Hello World", "s": 0.5, "l": 0.5 ])
        textField.text = def.stringForKey("str")
        saturationSlider.value = def.floatForKey("s")
        lightnessSlider.value = def.floatForKey("l")
        updateBackgroundColor()
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let nsString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        updateBackgroundColor(nsString)
        return true
    }
    @IBAction func sliderValueChanged(sender: AnyObject) {
        updateBackgroundColor()
    }

    private func updateBackgroundColor(var str: String? = nil) {
        let s = saturationSlider.value
        let l = lightnessSlider.value
        str = str ?? textField.text!
        saturationLabel.text = "Saturation\n\(s)"
        lightnessLabel.text = "Lightness\n\(l)"
        view.backgroundColor = ColorHash(str!, [CGFloat(s)], [CGFloat(l)]).color
        let def = NSUserDefaults.standardUserDefaults()
        def.setFloat(s, forKey: "s")
        def.setFloat(l, forKey: "l")
        def.setValue(str, forKey: "str")
        def.synchronize()
    }
}

