//
//  XMLHandler.swift
//  GnuCashViewer
//
//  Created by Patrick Van den Bergh on 30/12/2021.
//

import Foundation

class XMLElement: Hashable, Identifiable {
    let id = UUID()
    var parent: XMLElement? = nil
    var contents = ""
    var elementName = ""
    var children: [XMLElement]? = [XMLElement]()
    static func == (lhs: XMLElement, rhs: XMLElement) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

class XMLHandler: NSObject, XMLParserDelegate {
    var currentElement: XMLElement? = nil
    var elements = [XMLElement]()
    var accounts: [Account]
    var account = Account()

    init(accounts: [Account]) {
        self.accounts = accounts
        super.init()
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("parserDidStartDocument")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("parserDidEndDocument")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("didStartElement: \(elementName)")
        let element = XMLElement()
        element.parent = currentElement
        element.elementName = elementName
        currentElement = element
        if elementName == "gnc:account" {
            account = Account()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("didEndElement: \(elementName)")
        if currentElement != nil {
            if currentElement!.parent == nil {
                elements.append(currentElement!)
            } else {
                currentElement!.parent?.children?.append(currentElement!)
            }
            currentElement = currentElement!.parent
        }
    }
    
    func parser(_ parser: XMLParser, foundComment comment: String) {
        print("foundComment: \(comment)")
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        print("foundCDATA: \(CDATABlock)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.count > 0 {
            print("foundCharacters (\(string.count)): \(string)")
            currentElement?.contents.append(string)
        }
    }
}
