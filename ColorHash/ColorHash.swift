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
    private var _str: String, _brightness: [CGFloat], _saturation: [CGFloat]
    public var str: String { return _str }
    public var brightness: [CGFloat] { return _brightness }
    public var saturation: [CGFloat] { return _saturation }
    public init(_ str: String, _ saturation: [CGFloat] = defaultLS, _ brightness: [CGFloat] = defaultLS) {
        _str = str
        _saturation = saturation
        _brightness = brightness
    }
    public var bkdrHash: CGFloat {
        var hash: CGFloat = 0
        for char in "\(str)x".characters {
            if let scl = String(char).unicodeScalars.first?.value {
                if hash > maxSafeInteger {
                    hash = hash / seed2
                }
                hash = hash * seed + CGFloat(scl)
            }
        }
        return hash
    }
    public var HSB: (CGFloat, CGFloat, CGFloat) {
        var hash = CGFloat(bkdrHash)
        let H = (hash % (full - 1.0)) / full
        hash /= full
        let S = saturation[Int((full * hash) % CGFloat(saturation.count))]
        hash /= CGFloat(saturation.count)
        let B = brightness[Int((full * hash) % CGFloat(brightness.count))]
        return (H, S, B)
    }
    public var color: UIColor {
        let (H, S, B) = HSB
        return UIColor(hue: H, saturation: S, brightness: B, alpha: 1.0)
    }
}
