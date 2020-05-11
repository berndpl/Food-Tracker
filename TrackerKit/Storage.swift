//
//  Storage.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

struct key {
    static let appGroup = "group.de.plontsch.food-tracker.shared"
    static let fileName = "items.json"
    static let log = "healthlog_enabled"
}

public class Storage {
    
    // MARK: - Data
    
    class func filePath()->URL {
        guard let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: key.appGroup) else {
            do {
                return try temporaryPath().appendingPathComponent(key.fileName)
            } catch {
                fatalError("No Temporary Path: \(error)")
            }
        }
        let filePath = path.appendingPathComponent(key.fileName)
        return filePath
    }
    
    class func temporaryPath() throws -> URL {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        return URL(fileURLWithPath: path, isDirectory: true)
    }
    
    public class func save(state:State) {
        // Encode
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(state) else {
            fatalError("Error Encode JSON")
        }
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        // Save
        do {
            try jsonString?.write(to: Storage.filePath(), atomically: false, encoding: .utf8)
            print("Saved \(state)")
        }
        catch { fatalError("Error Writing File") }
    }
    
    public class func load()->State? {
        // Read
        do {
            let data = try Data(contentsOf: filePath(), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            guard let state = try? jsonDecoder.decode(State.self, from: data) else {
                print("Error decoding")
                return nil
            }
            return state
        }
        catch { print("No File Loaded") }
            
        return nil
    }
    
    // MARK: - User Default Health Log

    public class func toggleHealthLog(isEnabled:Bool) {
        UserDefaults(suiteName: key.appGroup)!.set(isEnabled, forKey: key.log)
        UserDefaults(suiteName: key.appGroup)!.synchronize()
        print("[Default] Toggle Caffeine Log \(UserDefaults(suiteName: key.appGroup)!.bool(forKey: key.log))")
    }
    
    public class func isHealthLogStateDetermined()->Bool {
        if let _:Bool = UserDefaults(suiteName: key.appGroup)!.object(forKey: key.log) as? Bool {
            return true
        }
        return false
    }
    
    public class func isHealthLogEnabled()->Bool {
        if let setting:Bool = UserDefaults(suiteName: key.appGroup)!.object(forKey: key.log) as? Bool {
            return setting
        }
        return false
    }
        
}
