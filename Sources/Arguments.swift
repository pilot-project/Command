//
//  Arguments.swift
//  Task
//
//  Created by Wesley Cope on 2/4/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

import Foundation

public struct Arguments {
    public static func parse() -> [String:[String:String]] {
        let arguments               = Process.arguments.dropFirst()
        var args:[String:String]    = [:]

        guard let name = arguments.first else {
            print("No action name found".color(.Red))
            exit(-1)
        }

        guard !name.hasPrefix("-") else {
            print("No command is given".color(.Red))
            exit(-1)
        }
        
        var skip:Int = 0
        for argument in arguments {
            if skip > 0 && arguments.indexOf(argument) == skip {
                continue
            }
            
            if argument.containsString("=") && argument.hasPrefix("--") {
                let components  = argument.componentsSeparatedByString("=")
                let key         = components.first!.stringByReplacingOccurrencesOfString("--", withString: "")
                let val         = components.last ?? ""
                
                args[key] = val
                
            }
            else if argument.containsString("-") {
                let index   = arguments.indexOf(argument) ?? 0
                let key     = argument.stringByReplacingOccurrencesOfString("-", withString: "")
                let next    = index + 1
                
                skip = next
                
                args[key] = arguments.count >= next ? arguments[next] : ""
                
            }
        }
        
        return [name: args]
    }
}
