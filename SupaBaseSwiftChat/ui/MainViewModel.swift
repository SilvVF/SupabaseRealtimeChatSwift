//
//  MainViewModel.swift
//  SupaBaseSwiftChat
//
//  Created by David Silver on 11/26/22.
//

import Foundation

class MainViewModel: ObservableObject {
    
    let chatService: ChatService
    @Published var messages: [IncomingMessage] = []
    
    init() {
        self.chatService = ChatService()
        subscribeToMessages()
    }
    
    func subscribeToMessages() {
        Task {
            await chatService.subscribeToMessages { message in
                    let dict = message.payload["record"]! as! NSDictionary
                    let data = IncomingMessage(
                        color: dict["color"]! as! Int,
                        content: dict["content"]! as! String,
                        id: dict["id"]! as! String,
                        sender: dict["sender"]! as! String,
                        time: dict["time"]! as! String
                    )
                DispatchQueue.main.async {
                    self.messages.insert(data, at: 0)
                }
            }
        }
    }

    func sendMessage(sender: String, content: String) {
        Task {
            await chatService.sendMessage(sender: sender, content: content)
        }
    }
}

struct IncomingMessage: Codable, Identifiable {
    let color: Int
    let content: String
    let id: String
    let sender: String
    let time: String
}
