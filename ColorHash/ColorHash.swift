//
//  ColorHash.swift
//  ColorHash
//
//  Created by Atsushi Nagase on 11/25/15.
//  Copyright © 2015 LittleApps Inc. All rights reserved.
//

import Foundation
import UIKit

let seed: CGFloat = 131.0
let seed2: CGFloat = 137.0
let maxSafeInteger = 9007199254740991.0 / seed2
let defaultLS: [CGFloat] = [0.35, 0.5, 0.65]
let full: CGFloat = 360.0

public class ColorHash {
    private var _str: String, _lightness: [CGFloat], _saturation: [CGFloat]
    public var str: String { return _str }
    public var lightness: [CGFloat] { return _lightness }
    public var saturation: [CGFloat] { return _saturation }
    public init(_ str: String, _ saturation: [CGFloat] = defaultLS, _ lightness: [CGFloat] = defaultLS) {
        _str = str
        _saturation = saturation
        _lightness = lightness
    }
    public var bkdirHash: CGFloat {
        var hash: CGFloat = 0
        for char in "\(str)x".characters {
            let s = String(char).unicodeScalars
            let scl = s[s.startIndex].value
            if hash > maxSafeInteger {
                hash = hash / seed2
            }
            hash = hash * seed + CGFloat(scl)
        }
        return hash
    }
    public var hsl: (CGFloat, CGFloat, CGFloat) {
        var hash = CGFloat(bkdirHash)
        let H = (hash % (full - 1.0)) / full
        hash /= full
        let S = saturation[Int(hash) % saturation.count]
        hash /= CGFloat(saturation.count)
        let L = lightness[Int(hash) % lightness.count]
        return (H, S, L)
    }
    public var color: UIColor {
        let (h, s, l) = hsl
        return UIColor(hue: h, saturation: s, brightness: l, alpha: 1.0)
    }
}