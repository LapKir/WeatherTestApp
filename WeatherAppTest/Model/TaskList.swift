//
//  TaskList.swift
//  WeatherAppTest
//
//  Created by Cyril on 19.07.21.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @Persisted var name: String = ""
    @Persisted var id: String = ""
    @Persisted var temp: String = ""
    
    convenience init(name: String, id: String, temp: String) {
        self.init()
        self.name = name
        self.id = id
        self.temp = temp
    }
}
