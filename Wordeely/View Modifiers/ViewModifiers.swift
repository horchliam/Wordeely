//
//  ViewModifiers.swift
//  Wordeely
//
//  Created by Liam Horch on 1/10/23.
//
import SwiftUI

struct RoundedButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(MyColors.primary)
            .cornerRadius(15)
            .shadow(color: MyColors.shadow, radius: 0, x: 2, y: 2)
    }
}
