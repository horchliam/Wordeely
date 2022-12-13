//
//  MatrixGrid.swift
//  Wordeely
//
//  Created by Liam Horch on 6/7/22.
//

import SwiftUI

struct MatrixGrid<Content: View>: View {
    
    typealias GridItemFactory = (_ row: Int, _ column: Int) -> Content
    
    let width: Int
    let height: Int
    let spacing: CGFloat
    let gridItemFactory: GridItemFactory
    
    private var columns: [GridItem] {
        .init(repeating: GridItem(.flexible()), count: width)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
            ForEach(0..<height) { row in
                ForEach(0..<width) { column in
                    gridItemFactory(row, column)
                }
            }
        }
    }
}

struct MatrixGrid_Previews: PreviewProvider {
    static var previews: some View {
        MatrixGrid(width: 5, height: 6, spacing: 8) { row, column in
            LetterTile("A", nil)
        }
        .padding()
    }
}
