//
//  GnuCashViewerApp.swift
//  GnuCashViewer
//
//  Created by Patrick Van den Bergh on 28/12/2021.
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct GnuCashViewerApp: App {
    
    var body: some Scene {
        DocumentGroup(viewing: GnuCashViewerDocument.self) { file in
            let rootElement = file.$document.xmlHandler.elements.first!
            ContentView(rootElement: rootElement)
                .padding()
        }
    }
}
