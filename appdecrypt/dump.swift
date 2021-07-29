//
//  dump.swift
//  appdump
//
//  Created by paradiseduo on 2021/7/29.
//

import Foundation
import MachO

class Dump {
    let consoleIO = ConsoleIO()
    func staticMode() {
        if CommandLine.argc < 3 {
            consoleIO.printUsage()
            return
        }
        if CommandLine.arguments.contains(where: { (s) -> Bool in
            return s=="-h" || s=="--help"
        }) {
            consoleIO.printUsage()
            return
        }
        
        let fileManager = FileManager.default
        let sourceUrl = CommandLine.arguments[1]
        let targetUrl = CommandLine.arguments[2]
        if !fileManager.fileExists(atPath: targetUrl) {
            do{
                try fileManager.copyItem(atPath: sourceUrl, toPath: targetUrl)
                consoleIO.writeMessage("Success to copy file.")
            }catch{
                consoleIO.writeMessage("Failed to copy file.", to: .error)
            }
        }
        
        Dump.mapFile(path: sourceUrl, mutable: false) { base_size, base_descriptor, base_raw in
            if let base = base_raw {
                Dump.mapFile(path: targetUrl, mutable: true) { dupe_size, dupe_descriptor, dupe_raw in
                    if let dupe = dupe_raw {
                        if base_size == dupe_size {
                            let header = UnsafeMutableRawPointer(mutating: dupe).assumingMemoryBound(to: mach_header_64.self)
                            assert(header.pointee.magic == MH_MAGIC_64)
                            assert(header.pointee.cputype == CPU_TYPE_ARM64)
                            assert(header.pointee.cpusubtype == CPU_SUBTYPE_ARM64_ALL)
                            
                            
                            guard var curCmd = UnsafeMutablePointer<load_command>(bitPattern: UInt(bitPattern: header)+UInt(MemoryLayout<mach_header_64>.size)) else {
                                return
                            }
                            
                            var segCmd : UnsafeMutablePointer<load_command>!
                            for _: UInt32 in 0 ..< header.pointee.ncmds {
                                segCmd = curCmd
                                if segCmd.pointee.cmd == LC_ENCRYPTION_INFO_64 {
                                    let command = UnsafeMutableRawPointer(mutating: segCmd).assumingMemoryBound(to: encryption_info_command_64.self)
                                    if Dump.dump(descriptor: base_descriptor, dupe: dupe, info: command.pointee) {
                                        command.pointee.cryptid = 0
                                    }
                                    break
                                }
                                curCmd = UnsafeMutableRawPointer(curCmd).advanced(by: Int(curCmd.pointee.cmdsize)).assumingMemoryBound(to: load_command.self)
                            }
                            munmap(base, base_size)
                            munmap(dupe, dupe_size)
                            consoleIO.writeMessage("Dump Success")
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: NSNotification.Name("stop"), object: nil)
                            }
                        } else {
                            munmap(base, base_size)
                            munmap(dupe, dupe_size)
                            consoleIO.writeMessage("If the files are not of the same size, then they are not duplicates of each other, which is an error.", to: .error)
                        }
                    } else {
                        munmap(base, base_size)
                        consoleIO.writeMessage("Read Dupe Fail", to: .error)
                    }
                }
            } else {
                consoleIO.writeMessage("Read Base Fail", to: .error)
            }
        }
    }
    
    static func dump(descriptor: Int32, dupe: UnsafeMutableRawPointer, info: encryption_info_command_64) -> Bool {
        let base = mmap(nil, Int(info.cryptsize), PROT_READ | PROT_EXEC, MAP_PRIVATE, descriptor, off_t(info.cryptoff))
        if base == MAP_FAILED {
            return false
        }
        let error = CBridage.encrypted(base!, cryptsize: Int(info.cryptsize), cryptid: info.cryptid)
        if error != 0 {
            munmap(base!, Int(info.cryptsize))
            return false
        }
        memcpy(dupe+UnsafeMutableRawPointer.Stride(info.cryptoff), base!, Int(info.cryptsize))
        munmap(base, Int(info.cryptsize))
        
        return true
    }
    
    static func mapFile(path: UnsafePointer<CChar>, mutable: Bool, handle: (Int, Int32, UnsafeMutableRawPointer?)->()) {
        let f = open(path, mutable ? O_RDWR : O_RDONLY)
        if f < 0 {
            handle(0, 0, nil)
            return
        }
        
        var s = stat()
        if fstat(f, &s) < 0 {
            close(f)
            handle(0, 0, nil)
            return
        }
        
        let base = mmap(nil, Int(s.st_size), mutable ? PROT_READ | PROT_WRITE : PROT_READ, mutable ? MAP_SHARED : MAP_PRIVATE, f, 0)
        if base == MAP_FAILED {
            close(f)
            handle(0, 0, nil)
            return
        }
        
        handle(Int(s.st_size), f, base)
    }
    
}

