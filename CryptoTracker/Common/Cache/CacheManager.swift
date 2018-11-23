//
//  CacheManager.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation


enum CacheError: Error {
    case invalidPath
    case writingFailed
}

fileprivate enum Default {
    static let key = "Shared"
}


class CacheManager {
    
    let directory: URL?
    let cacheName: String
    let fileManager: FileManager
    
    init(cacheName: String, directory: URL? = Defaults.defaultDirectory, fileManager: FileManager = Defaults.defaultFileManager) {
        self.cacheName = cacheName
        self.directory = directory
        self.fileManager = fileManager
    }


    // MARK: - Cache functions
    
    /// Caches a Codable object for a given key (File). Throws if writing fails
    func cache<T: Codable>(_ value: T, with key: String = Default.key) throws {
        do {
            let data = try JSONEncoder().encode(value)
            guard let directory = directory else { throw CacheError.invalidPath }
            let path = directory.appendingPathComponent(cacheName)
            try fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            try data.write(to: path.appendingPathComponent(key), options: [.atomic])
        } catch {
            print("Error caching: \(error.localizedDescription)")
            throw CacheError.writingFailed
        }
    }
    
    /// Retrieves the Codable object from cache, nil if empty
    func getCache<T: Codable>(for key: String = Default.key) -> T? {
        do {
            guard let directory = directory else { throw CacheError.invalidPath }
            let filename = directory.appendingPathComponent(cacheName).appendingPathComponent(key)
            if let value = try? Data(contentsOf: filename) {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: value as Data)
                    return decoded
                } catch {
                    print("Error decoding: \(error.localizedDescription)")
                    deleteCache() // Clear cache if decoding fails
                    return nil
                }
                
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    /// Deletes the cache directory
    func deleteCache() {
        guard let filename = directory?.appendingPathComponent(cacheName) else { return }
        try? fileManager.removeItem(at: filename)
    }
}


// MARK: - Defaults
fileprivate enum Defaults {
    static var defaultDirectory: URL? {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard paths.count > 0 else { return nil }
        return paths[0]
    }
    
    static var defaultFileManager: FileManager {
        return FileManager.default
    }
}
