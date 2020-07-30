//
//  File.swift
//  
//
//  Created by Rob Jonson on 30/07/2020.
//

import Foundation

public protocol HSObserves {
    @discardableResult
    func activate() -> Self
    func deactivate()
}
