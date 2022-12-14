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
    
    init(urlString: String, key: String) {
        client = SupabaseClient(
            supabaseURL: URL(string: urlString)!,
            supabaseKey: key
        )
    }
    
    convenience init() {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        let url = nsDictionary!["url"]! as! String
        let key = nsDictionary!["apikey"]! as! String
        self.init(urlString: url, key: key)
    }
    
    func sendMessage(
        sender: String,
        content: String
    ) async {
        do {
            try await client.database.from("messages")
                .insert(values:
                    OutgoingMessage(
                        sender: sender.ifEmpty { "anon-user" },
                        content: content.ifEmpty { "I have no message" }
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

extension String {
    func ifEmpty(task: () -> String) -> String {
        if (self.isEmpty) {
            return task()
        }
        return self
    }
}

