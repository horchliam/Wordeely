//
//  TitleView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/26/22.
//

import SwiftUI
import CoreData

struct TitleView: View {
    @State var guesses: [Guess] = [Guess(text: "TESTS")]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 100) {
            Text("Title View")
            NavigationLink(destination: GameView(guesses: $guesses),
                           label: { Text("Play") })
            NavigationLink(destination: StoreView(),
                            label: { Text("Store") })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
