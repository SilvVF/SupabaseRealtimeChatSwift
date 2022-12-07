
//.swift
//  SupaBaseSwiftChat
//
//  Created by David Silver on 11/26/22.
//

import SwiftUI

@main
struct SupaBaseSwiftChatApp: App {

    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    
    var body: some Scene {
        
        
        
        WindowGroup {
            ContentView(
                messages: viewModel.messages,
                onClick: { sender, message in
                    viewModel.sendMessage(sender: sender, content: message)
                }
            )
        }
    }
}
