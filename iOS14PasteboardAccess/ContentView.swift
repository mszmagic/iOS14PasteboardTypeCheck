//
//  ContentView.swift
//  iOS14PasteboardAccess
//
//  Created by Shunzhe Ma on 2020/09/06.
//  Copyright © 2020 Shunzhe Ma. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var pasteboardContent: String = ""
    
    @State var probablyNumber: Bool = false
    @State var probablySearchQuery: Bool = false
    @State var probablyURL: Bool = false
    
    var body: some View {
        
        Form {
            
            Section {
                
                // パターンを検出
                Button(action: {
                    UIPasteboard.general.detectPatterns(for: [.number, .probableWebSearch, .probableWebURL]) { result in
                        resetVariables()
                        switch result {
                            case .success(let patterns):
                                if patterns.contains(.number) {
                                    // 数字
                                    self.probablyNumber = true
                                } else if patterns.contains(.probableWebSearch) {
                                    // ウェブ検索クエリー
                                    self.probablySearchQuery = true
                                } else if patterns.contains(.probableWebURL) {
                                    // URL
                                    self.probablyURL = true
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
                }, label: {
                    Text("パターンを検出")
                })
                
                HStack {
                    Text("おそらく数字")
                    Spacer()
                    Image(systemName: probablyNumber ? "checkmark.circle.fill" : "xmark.circle.fill")
                }
                
                HStack {
                    Text("おそらくウェブ検索クエリー")
                    Spacer()
                    Image(systemName: probablySearchQuery ? "checkmark.circle.fill" : "xmark.circle.fill")
                }
                
                HStack {
                    Text("おそらくURL")
                    Spacer()
                    Image(systemName: probablyURL ? "checkmark.circle.fill" : "xmark.circle.fill")
                }
                
            }
            
            Section {
                
                // クリップボードの内容を取得
                Button(action: {
                    self.pasteboardContent = UIPasteboard.general.string ?? ""
                }, label: {
                    Text("クリップボードの内容を取得")
                })
                
                Text(pasteboardContent)
                
            }
            
        }
        
    }
    
    func resetVariables() {
        probablyNumber = false
        probablySearchQuery = false
        probablyURL = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
