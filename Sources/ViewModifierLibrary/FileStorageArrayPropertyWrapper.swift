//
//  FileStorageArrayPropertyWrapper.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/1/28.
//  Reference: https://stackoverflow.com/a/61201896/3295047

import Foundation

private let fileManager = FileManager.default
private let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first

@propertyWrapper public
struct FileStorageArray<Value: Codable> {
    
    private let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public var wrappedValue: [Value] {
        get {
            do {
                return try readFile(fileName: key)
            } catch {
                print(error)
                return []
            }
        }
        set {
            do {
                try newValue.saveToFile(fileName: key)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Helper
    
    func readFile(fileName: String) throws -> [Value] {
        guard let dir = dir else { return [] }
        
        let url = dir.appendingPathComponent(fileName)
        let data = try Data(contentsOf: url)
        let value = try JSONDecoder().decode([Value].self, from: data)
        return value
    }
}

private extension Array where Element: Encodable {
    func saveToFile(fileName: String) throws {
        guard let dir = dir else { return }
        
        let fileURL = dir.appendingPathComponent(fileName)
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}
