//
//  main.swift
//  appdecrypt
//
//  Created by paradiseduo on 2021/7/29.
//

import Foundation
import MachO

let version = "2.4"

var running = true

Dump().staticMode()

NotificationCenter.default.addObserver(forName: NSNotification.Name("stop"), object: nil, queue: OperationQueue.main) { (noti) in
    running = false
}

let runLoop = RunLoop.current
let distantFuture = Date.distantFuture
while running == true && runLoop.run(mode: RunLoop.Mode.default, before: distantFuture) {
    
}
