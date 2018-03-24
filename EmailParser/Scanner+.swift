//
//  Scanner+.swift
//  EmailParser
//
//  Created by Tomochika Hara on 2018/03/24.
//  Copyright © 2018年 Hai Nguyen. All rights reserved.
//

import Foundation

extension Scanner {
  
  func scanUpToCharactersFrom(_ set: CharacterSet) -> String? {
    var result: NSString?
    return scanUpToCharacters(from: set, into: &result) ? (result as String?) : nil
  }
  
  func scanUpTo(_ string: String) -> String? {
    var result: NSString?
    return self.scanUpTo(string, into: &result) ? (result as String?) : nil
  }
  
  func scanDouble() -> Double? {
    var result: Double = 0
    return self.scanDouble(&result) ? result : nil
  }
  
}
