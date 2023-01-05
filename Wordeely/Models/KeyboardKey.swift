//
//  KeyboardKey.swift
//  Wordeely
//
//  Created by Liam Horch on 6/2/22.
//

import Foundation

struct KeyboardKey: Identifiable {
    let id: UUID = UUID() // Unique identifier required for KeyboardKey
    var letter: Character
}
