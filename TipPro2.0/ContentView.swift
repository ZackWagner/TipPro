//
//  ContentView.swift
//  TipPro2.0
//
//  Created by Zack Wagner on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    var body: some View {
        VStack {
        NavigationView {
            VStack {
                if texts.count > 0{
                    List{
                        ForEach(texts){text in
                            NavigationLink(
                                destination: ScrollView{Text(text.content)},
                                label: {
                                    Text(text.content).lineLimit(1)
                                })
                        }
                    }
                }
                else{
                    Text("No scan")
                }
            }
            .navigationTitle("Welcome to TipPro!")
            .navigationBarItems(trailing: Button(action: {
                self.showScannerSheet = true
            }, label: {
                Text("Scan Checkout")
            })
                .sheet(isPresented: $showScannerSheet, content: {
                    makeScannerView()
                })
            )
        }
            
    
            if texts.count > 0{
                let text = texts.last
                let printable = Interpreter.calculateTips(checkout: text!.content)
                Text(printable)
                
            }
            else {
                
            }
            Spacer(minLength: 200)
    
    }
    }
    private func makeScannerView()-> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in:
                    .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

