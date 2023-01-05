//
//  CharacterCollection.swift
//  Wordeely
//
//  Created by Liam Horch on 1/5/23.
//

import Foundation

class CharacterCollection {
    var letters: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    func getRandom() -> Character {
        let toReturn: Character = letters.randomElement()!
        letters.remove(toReturn)
        return toReturn
    }
    
    func pop(c: Character) -> Character? {
        let toReturn: Character? = letters.remove(c)
        return toReturn
    }
}
