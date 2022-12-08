//
//  ContentView.swift
//  SupaBaseSwiftChat
//
//  Created by David Silver on 11/26/22.
//

import SwiftUI

struct ContentView : View {


    var messages: [IncomingMessage]
    var onClick: (_ sender: String, _ message: String) -> Void
    
    @State var userMessage: String = ""
    @State var name: String = ""
    
    func getColor(c: Int) -> Color {
        switch(c) {
        case 0: return Color.gray
        case 1: return Color.blue
        case 2: return Color.green
        case 3: return Color.purple
        case 4: return Color.cyan
        case 5: return Color.yellow
        default: return Color.red
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(messages) { message in
                        
                        let color: Color = getColor(c: message.color)
                        
                        HStack(alignment: .top) {
                            Text(message.sender)
                                .foregroundColor(
                                    color
                                )
                                .padding(8)
                            Text(message.content)
                        }
                    }
                }
            }
            TextField("Name", text: $name)
                .padding(8)
            TextField("Enter a message", text: $userMessage)
                .padding(8)
            Button(
                action: {
                    self.onClick(name, userMessage)
                },
                label: {
                    Text("send message")
                }
            )
            .padding(16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            messages: [],
            onClick: {
                _, _ in
            }
        )
    }
}
