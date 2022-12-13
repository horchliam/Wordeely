//
//  StoreView.swift
//  Wordeely
//
//  Created by Liam Horch on 5/31/22.
//

import SwiftUI

struct StoreView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var score: Int
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...10, id: \.self) { _ in
                    // Replace with store cell
                    LetterTile("X", nil)
                        .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {self.presentationMode.wrappedValue.dismiss()})
            { Text("Back") }
        )
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(score: 100)
    }
}
