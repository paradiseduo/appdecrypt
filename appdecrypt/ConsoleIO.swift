//
//  ConsleIO.swift
//  appdump
//
//  Created by paradiseduo on 2021/7/29.
//

import Foundation


enum OutputType {
  case error
  case standard
}

class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
            case .standard:
                print("\(message)")
            case .error:
                fputs("Error: \(message)\n", stderr)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("stop"), object: nil)
                }
        }
    }
    
    func printUsage() {
        writeMessage("""
        Version \(version)
        
        appdecrypt is a tool to make decrypt application encrypted binaries on macOS when SIP-enabled.
        
        Examples:
            appdecrypt /Applicaiton/Test.app/Wrapper/Test.app/Test /Users/admin/Desktop/Test
        
        USAGE: appdecrypt encryptMachO_Path decryptMachO_Path
        
        ARGUMENTS:
          <encryptMachO_Path>     The encrypt machO file path.
          <decryptMachO_Path>     The path output decrypt machO file.
        
        OPTIONS:
          -h, --help              Show help information.
        """)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("stop"), object: nil)
        }
    }
}
