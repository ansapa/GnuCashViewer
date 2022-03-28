//
//  ContentView.swift
//  GnuCashViewer
//
//  Created by Patrick Van den Bergh on 28/12/2021.
//

import SwiftUI

struct ContentView: View {
    @Binding var rootElement: XMLElement

    var body: some View {
        NavigationView {
            ChildrenView(children: rootElement.children)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rootElement: .constant(GnuCashViewerDocument().xmlHandler.elements.first!))
    }
}
