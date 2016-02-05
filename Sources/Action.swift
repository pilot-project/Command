//
//  Action.swift
//  Task
//
//  Created by Wesley Cope on 2/4/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

public struct Action {
    public let name:String
    public let description:String?
    public let handler:((flags:[String:String]?) -> Void)
}