//
//  Interpreter.swift
//  TipPro2.0
//
//  Created by Zack Wagner on 8/17/23.
//

import Foundation
struct Interpreter {
    static func calculateTips(checkout: String) -> String {
            
        
        let index1 = checkout.firstIndex(of: "+")
        let index1prime = checkout.index(index1!, offsetBy: 1)
        let index2 = checkout[index1prime..<checkout.endIndex].firstIndex(of: "+")
        let index2prime = checkout.index(index2!, offsetBy: 1)
        let index3 = checkout[index2prime..<checkout.endIndex].firstIndex(of: "+")
        
        let startIndex = checkout.index(index2prime, offsetBy: 2)
        let endIndex = checkout.index(index3!, offsetBy: -2)
        let barString = checkout[startIndex..<endIndex]
        
        var barTipOut = 0
        if barString.contains(". ") {
            let dotIndex = barString.firstIndex(of: ".")
            let decimalPartIndex = barString.index(dotIndex!, offsetBy: 2)
            let wholeStartIndex = barString.index(barString.startIndex, offsetBy: 0)
            
            
            let wholePart = Double(barString[wholeStartIndex..<dotIndex!]) ?? 0.0
            let decimalPart = Double(barString[decimalPartIndex..<barString.endIndex]) ?? 0.0
            
            
            let barSales = (Double(wholePart) + 0.01*decimalPart)
           
            barTipOut = Int(0.04*barSales)
        }
        else {
            let startindex = barString.index(barString.startIndex, offsetBy: 0)
            let barSales = Double(barString[startindex..<barString.endIndex]) ?? 0.0
            print(barSales)
            barTipOut = Int(0.04*barSales)
        }
        
            if let firstIndex = checkout.firstIndex(of: "=") {
                let secondIndex = checkout.index(firstIndex, offsetBy: 3)
                
                guard let nextIndex = checkout[secondIndex..<checkout.endIndex].firstIndex(of: "=") else { return "" }
                let goofyIndex = checkout.index(nextIndex, offsetBy: 3)
                guard let nextnextIndex = checkout[nextIndex..<checkout.endIndex].firstIndex(of: "\n") else { return "" }
                let goofyIndex2 = checkout.index(nextnextIndex, offsetBy: 3)
                guard let nextnextnextIndex = checkout[goofyIndex2..<checkout.endIndex].firstIndex(of: "\n") else { return "" }
            
                if let startIndex = checkout[firstIndex..<checkout.endIndex].firstIndex(of: "\n") {
                    let endIndex = checkout[firstIndex..<checkout.endIndex].firstIndex(of: "\n") ?? checkout.endIndex
                    let cashString = String(String(checkout[nextnextIndex..<nextnextnextIndex]))
                    var cashPayments = 0.0
                  
                    if cashString.contains(". ") {
                        let dotIndex = cashString.firstIndex(of: ".")
                        let decimalPartIndex = cashString.index(dotIndex!, offsetBy: 2)
                        let wholeStartIndex = cashString.index(cashString.startIndex, offsetBy: 1)
                        
                        
                        let wholePart = Double(cashString[wholeStartIndex..<dotIndex!]) ?? 0.0
                        let decimalPart = Double(cashString[decimalPartIndex..<cashString.endIndex]) ?? 0.0
                        
                    
                        cashPayments = Double(wholePart) + 0.01*decimalPart
                    } else {
                        let startindex = cashString.index(cashString.startIndex, offsetBy: 1)
                        cashPayments = Double(cashString[startindex..<cashString.endIndex]) ?? 0.0
                    }
                    if let ccTipStringIndex = checkout[secondIndex..<checkout.endIndex].firstIndex(of: "$") {
                        if let ccTipEndIndex = checkout[ccTipStringIndex..<checkout.endIndex].firstIndex(of: "\n") {
                            let ccTipStringStart = checkout.index(ccTipStringIndex, offsetBy: 1)
                            let ccTipString = String(checkout[ccTipStringStart..<ccTipEndIndex])
                            var ccTips = 0.0
                        
                            if ccTipString.contains(" ") {
                                let dotIndex = ccTipString.firstIndex(of: ".")
                                let decimalPartIndex = ccTipString.index(dotIndex!, offsetBy: 2)
                                let wholePart = Double(ccTipString[ccTipString.startIndex..<dotIndex!])
                                let decimalPart = Double(ccTipString[decimalPartIndex..<ccTipString.endIndex])
                                ccTips = wholePart! + decimalPart!
                            } else {
                                ccTips = Double(ccTipString) ?? 0.0
                            }
                            let totalTips = ccTips + cashPayments * 0.15
                            
                            let busfoodruntipout = Int((totalTips - Double(barTipOut)) * 0.1)
                            let claimedTips = Int(totalTips) - busfoodruntipout - barTipOut
                            
                            return "Bar Money Owed = \(barTipOut)\n" +
                            "Bus/Host/Expo Money Owed = \(busfoodruntipout)\n" +
                            "Tips to claim = \(claimedTips)"
                        }
                    }
                }
        }
        return  ""
    }
    static func indexOf(str:String, chr: Character) -> Int {
        if let firstIndex = str.firstIndex(of: chr) {
            let index = str.distance(from: str.startIndex, to: firstIndex)
            return index
        }
        else {
            return(-1)
        }
    }
}
