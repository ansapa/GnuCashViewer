//
//  GnuCashViewerDocument.swift
//  GnuCashViewer
//
//  Created by Patrick Van den Bergh on 28/12/2021.
//

import SwiftUI
import UniformTypeIdentifiers
import GZIP
import os

extension UTType {
    static var gnuCashDocument: UTType {
        UTType(importedAs: "com.ansapa.gnucash")
    }
}

struct GnuCashViewerDocument: FileDocument {
    var data: Data
    var text: String
    let logger = Logger(subsystem: "com.ansapa.GnuCashViewer", category: "GnuCashViewerDocument")
    var accounts = [Account]()
    var xmlHandler: XMLHandler
    
    init() {
        self.text = ""
        self.data = Data()
        self.xmlHandler = XMLHandler(accounts: accounts)
    }

    static var readableContentTypes: [UTType] { [.gnuCashDocument] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.init()
        
        if (data as NSData).isGzippedData() {
            if let unzippedData = (data as NSData).gunzipped() {
                self.data = data
                self.text = String(decoding: unzippedData , as: UTF8.self)
                let xmlparser = XMLParser(data: unzippedData)
                xmlparser.delegate = xmlHandler
                xmlparser.parse()
            } else {
                logger.error("Could not unzip data.")
            }
        } else {
            logger.error("Could not unzip data.")
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
