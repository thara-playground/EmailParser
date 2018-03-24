//
//  HardwarePost.swift
//  EmailParser
//
//  Created by Tomochika Hara on 2018/03/24.
//  Copyright © 2018年 Hai Nguyen. All rights reserved.
//

import Foundation

struct HardwarePost {
  let email: String
  let sender: String
  let subject: String
  let date: String
  let organization: String
  let numberOfLines: Int
  let message: String
  
  let costs: [Double]
  let keywords: Set<String>
  
  init(fromData data: Data) {
    let parser = ParserEngine()
    let string = String(data: data, encoding: String.Encoding.utf8) ?? ""
    let scanner = Scanner(string: string)
    let metadata = scanner.scanUpTo("\n\n") ?? ""
    let (sender, email, subject, date, organization, lines) = parser.fieldsByExtractingFrom(metadata)
    
    self.sender = sender
    self.email = email
    self.subject = subject
    self.date = date
    self.organization = organization
    self.numberOfLines = lines
    
    let startIndex = string.index(string.startIndex, offsetBy: scanner.scanLocation)
    let message = string[startIndex..<string.endIndex]
    self.message = message.trimmingCharacters(in: .whitespaces)
    
    self.costs = parser.costInfoByExtractingFrom(message)
    self.keywords = parser.keywordsByExtractingFrom(message)
  }
}
