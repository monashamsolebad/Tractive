//
//  UIColor+Colors.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-02.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

extension UIColor {
  static var systemBlue: UIColor {
    return  UIColor(red: 0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
  }
  
  public convenience init?(hex: String) {
    let r, g, b, a: CGFloat
    
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])
      
      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          a = CGFloat(hexNumber & 0x000000ff) / 255
          
          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      }
    }
    
    return nil
  }
}
