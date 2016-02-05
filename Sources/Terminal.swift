//
//  Terminal.swift
//  Task
//
//  Created by Wesley Cope on 2/4/16.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

import Foundation

public enum TextColor : Int {
    case Black = 30
    case Red
    case Green
    case Yellow
    case Blue
    case Magenta
    case Cyan
    case White
    case Gray = 90
}

public enum TextBackgroundColor : Int {
    case Black = 30
    case Red
    case Green
    case Yellow
    case Blue
    case Magenta
    case Cyan
    case White
    case Gray = 90
}

public enum TextStyle : Int {
    case Bold = 1
    case Dim
    case Italic
    case Underline
    case Inverse = 7
    case Hidden
    case Strikethrough
}

public struct Terminal {
    public static let ESCAPE = "\u{001b}"
    
    public static var colorSupported:Bool {
        let type        = String.fromCString(getenv("TERM"))
        let arguments   = Process.arguments
        
        if arguments.contains("--no-color") || arguments.contains("--color=false") {
            return false
        }
        
        if arguments.contains("--color") || arguments.contains("--color=true") {
            return true
        }
        
        if let type = type {
            return type.hasPrefix("screen")
                || type.hasPrefix("xterm")
                || type.hasPrefix("vt100")
                || type.containsString("color")
                || type.containsString("ansi")
                || type.containsString("cygwin")
                || type.containsString("linux")
        }
        
        return true
    }
}


public extension String {
    public func color(color:TextColor) -> String {
        return apply((color.rawValue, 39))
    }
    
    public func background(color:TextBackgroundColor) -> String {
        return apply((color.rawValue, 49))
    }
    
    public func style(style:TextStyle) -> String {
        return style == .Bold ? apply((style.rawValue, 22)) : apply((style.rawValue, style.rawValue + 20))
    }
    
    private func apply(code:(Int, Int)) -> String {
        if !Terminal.colorSupported {
            return self
        }
        
        return "\(Terminal.ESCAPE)[\(code.0)m\(self)\(Terminal.ESCAPE)[\(code.1)m"
    }
}




