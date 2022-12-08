//
//  Repository.swift
//  SupaBaseSwiftChat
//
//  Created by David Silver on 11/26/22.
//

import Foundation
import Supabase
import Realtime

class ChatService {
    
    let client: SupabaseClient
    
    let color = (0...6).randomElement()
    
    init() {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        client = SupabaseClient(
            supabaseURL: URL(string: nsDictionary!["url"]! as! String)!,
            supabaseKey:nsDictionary!["apikey"]! as! String
        )
    }
    
    func sendMessage(
        sender: String,
        content: String
    ) async {
        do {
            try await client.database.from("messages")
                .insert(values:
                            Message(
                                sender: sender,
                                content: content,
                                color: color,
                                timestamp: nil
                            )
                )
                .execute()
        } catch {
            print("insert failed")
        }
    }
    
    func subscribeToMessages(
        onReceived: @escaping (Realtime.Message) -> Void
      ) async {
          client.realtime.connect()
          let changes = client.realtime.channel(.table("messages", schema: "public"))
          changes.on(.insert, callback: onReceived)
          changes.subscribe()
      }
}

struct Message: Codable {
    let sender: String
    let content: String
    var color: Int? = 0
    var timestamp: String? = nil
}
