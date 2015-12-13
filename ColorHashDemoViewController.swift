//
//  ColorHashDemoViewController.swift
//  ColorHashDemo
//
//  Created by Atsushi Nagase on 11/25/15.
//  Copyright © 2015 LittleApps Inc. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    class ColorHashDemoViewController: UIViewController, UITextFieldDelegate {
        @IBOutlet weak var textField: UITextField!
        @IBOutlet weak var saturationSlider: UISlider!
        @IBOutlet weak var brightnessSlider: UISlider!
        @IBOutlet weak var saturationLabel: UILabel!
        @IBOutlet weak var brightnessLabel: UILabel!

        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            let nsString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            updateBackgroundColor(nsString)
            return true
        }
    }
#elseif os(OSX)
    import Cocoa
    class ColorHashDemoViewController: NSViewController, NSTextFieldDelegate {
        @IBOutlet weak var textField: NSTextField!
        @IBOutlet weak var saturationSlider: NSSlider!
        @IBOutlet weak var brightnessSlider: NSSlider!
        @IBOutlet weak var saturationLabel: NSTextField!
        @IBOutlet weak var brightnessLabel: NSTextField!

        override func controlTextDidChange(obj: NSNotification) {
            updateBackgroundColor()
        }
    }
#endif

extension ColorHashDemoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let def = NSUserDefaults.standardUserDefaults()
        def.registerDefaults(["str": "Hello World", "s": 0.5, "l": 0.5 ])
        #if os(iOS) || os(tvOS)
            textField.text = def.stringForKey("str")
            saturationSlider.value = def.floatForKey("s")
            brightnessSlider.value = def.floatForKey("l")
        #elseif os(OSX)
            textField.stringValue = def.stringForKey("str") ?? ""
            saturationSlider.floatValue = def.floatForKey("s")
            brightnessSlider.floatValue = def.floatForKey("l")
        #endif
        updateBackgroundColor()
    }
    @IBAction func sliderValueChanged(sender: AnyObject) {
        updateBackgroundColor()
    }

    private func updateBackgroundColor(var str: String? = nil) {
        #if os(iOS) || os(tvOS)
            let s = saturationSlider.value
            let l = brightnessSlider.value
            str = str ?? textField.text!
        #elseif os(OSX)
            let s = saturationSlider.floatValue
            let l = brightnessSlider.floatValue
            str = str ?? textField.stringValue
        #endif
        self.setBackgroundColor(ColorHash(str!, [CGFloat(s)], [CGFloat(l)]).color)
        setLabelText(saturationLabel, text: "Saturation\n\(s)")
        setLabelText(brightnessLabel, text: "Brightness\n\(l)")
        let def = NSUserDefaults.standardUserDefaults()
        def.setFloat(s, forKey: "s")
        def.setFloat(l, forKey: "l")
        def.setValue(str, forKey: "str")
        def.synchronize()
    }

    #if os(iOS) || os(tvOS)
    private func setBackgroundColor(c: UIColor) {
        self.view.backgroundColor = c
    }

    private func setLabelText(label: UILabel, text: String) {
        label.text = text
    }
    #elseif os(OSX)
    private func setBackgroundColor(c: NSColor) {
        let layer = CALayer()
        layer.backgroundColor = c.CGColor
        view.wantsLayer = true
        view.layer = layer
    }

    private func setLabelText(label: NSTextField, text: String) {
        label.stringValue = text
    }
    #endif
}

