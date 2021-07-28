//
//  DataBaseManager.swift
//  WeatherAppTest
//
//  Created by Cyril on 19.07.21.
//

import Foundation
import RealmSwift

final class DataBaseManager {
    private static var sharedManager: DataBaseManager = {
        let dataBaseManager = DataBaseManager()
        
        return dataBaseManager
    }()
    
    // MARK: -

    private var realm: Realm?
    
    // Initialization
    
    private init() {
        self.realm = try? Realm()
    }
    
    // MARK: - Accessors
    
    class func shared() -> DataBaseManager {
        return sharedManager
    }

    func fetch<Element: Object>(_ type: Element.Type, completion: @escaping ([Element]) -> ()) {
            guard let results = self.realm?.objects(type) else {
                completion([])
                return
            }
            completion(Array(results))
    }

    func write(_ object: Object) {
            try? self.realm?.write({
                self.realm?.add(object)
            })
    }

    func write(_ objects: [Object]) {
            try? self.realm?.write({
                self.realm?.add(objects)
            })
    }
}
