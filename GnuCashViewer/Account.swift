//
//  Account.swift
//  GnuCashViewer
//
//  Created by Patrick Van den Bergh on 31/12/2021.
//

import Foundation

class Account {
    let id = UUID()
    var parent: Account? = nil
    var children: [Account] = [Account]()
    var act_id = ""
    var act_name = ""
    var act_type = ""
    var act_description = ""
    var act_parent = ""
}
