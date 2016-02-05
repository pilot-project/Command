//
//  extensions.swift
//  Task
//
//  Created by Wesley Cope on 2/4/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

import Foundation

public extension String {

    public var length: Int {
        return self.characters.count
    }
    
    public subscript(index: Int) -> Character {
        let index = startIndex.advancedBy(index)
        
        return self[index]
    }
    
    public subscript(range: Range<Int>) -> String {
        let start       = startIndex.advancedBy(range.startIndex)
        let end         = startIndex.advancedBy(range.endIndex)
        let subrange    = start ..< end
        
        return self[subrange]
    }
    
    public subscript(index1: Int,  index2: Int) -> NSString {
        
        let strSize         = self.characters.count
        var indexFirst:Int  = index1
        var indexLast:Int   = index2
        
        if indexFirst < 0 {
            indexFirst = strSize - index1
            
            if index1 < 0 {
                indexFirst = 0
            }
        }
        
        if index2 <= 0 {
            indexLast = strSize - index2
            
            if indexLast < indexFirst {
                indexLast = indexFirst
            }
        }
        
        
        return self[Range(start:indexFirst, end: indexLast)]
    }

    
}

public func +<T>(lhs: [T], rhs: T) -> [T] {
    var ary = lhs
    ary.append(rhs)
    
    return ary
}