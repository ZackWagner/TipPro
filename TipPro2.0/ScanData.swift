//
//  ScanData.swift
//  TipPro2.0
//
//  Created by Zack Wagner on 8/14/23.
//

import Foundation

struct ScanData:Identifiable {
    var id = UUID()
    let content:String
    
    init(content:String) {
        self.content = content
    }
}
