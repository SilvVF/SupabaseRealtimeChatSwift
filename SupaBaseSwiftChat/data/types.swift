//
//  types.swift
//  SupaBaseSwiftChat
//
//  Created by David Silver on 12/7/22.
//

import Foundation


struct IncomingMessage: Codable, Identifiable {
    let color: Int
    let content: String
    let id: String
    let sender: String
    let time: String
}

struct OutgoingMessage: Codable {
    let sender: String
    let content: String
    var color: Int = 0
}
