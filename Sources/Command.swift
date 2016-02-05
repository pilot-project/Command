//
//  Command.swift
//  Task
//
//  Created by Wesley Cope on 2/4/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

import Foundation

public class Command {
    public static let instance = Command()
    
    public var actions:[Action] = []
    public lazy var help:Action = {
        let _help = Action(name: "help", description: "Get some help") { (argument) in
            
        }
        
        return _help
    }()
    
    public init(actions:[Action]? = nil) {
        self.actions = actions ?? []
    }
    
    public func add(action:Action) {
        actions.append(action)
    }
    
    public func exec(command:String, arguments:[String]? = []) -> Int32 {
        guard NSFileManager.defaultManager().fileExistsAtPath(command) else {
            print("command not found: \(command)".color(.Red))
            exit(-1)
        }

        let task        = NSTask()
        task.launchPath = command
        task.arguments  = arguments

        task.launch()
        task.waitUntilExit()

        return task.terminationStatus
    }

    public func run() {
        let arguments   = Arguments.parse()
        let filter      = actions.filter { $0.name == arguments.keys.first! }
        
        guard let action = filter.first else {
            print("No action specificied".color(.Red))
            exit(-1)
        }
        
        let flags = arguments[action.name]
        
        action.handler(flags:flags)
    }
}
