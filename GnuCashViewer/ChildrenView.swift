//
//  ChildrenView.swift
//  GnuCashViewer
//
//  Created by Patrick Van den Bergh on 04/01/2022.
//

import SwiftUI

struct ChildrenView: View {
    let children: [XMLElement]?
    
    var body: some View {
        if let children = self.children {
            List {
                ForEach (children) { child in
                    NavigationLink(destination: ChildrenView(children: child.children)) {
                        Text(child.elementName)
                    }
                }
            }
        } else {
            Text("no children")
        }
    }
}

struct ChildrenView_Previews: PreviewProvider {
    static var previews: some View {
        ChildrenView(children: GnuCashViewerDocument().xmlHandler.elements.first!.children)
    }
}
