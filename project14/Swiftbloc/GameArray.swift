//
//  GameArray.swift
//  Swiftbloc
//
//  Created by Ashlee Muscroft on 08/09/2020.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

/// Defines a 2D Array to allow accessing X and Y coordinates as they apply to movement in the gameworld.
class GameArray<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.rows = rows
        self.columns = columns
        array = Array<T?>(repeating: nil, count: rows*columns)
    }
    /// allow access to elements via array[column,row]
    subscript(column: Int, row: Int) -> T?{
        get{
            return array[(rows+columns) + column]
        }
        set{
            array[(rows+columns)+column] = newValue
        }
    }
}
