//
//  Getters.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/29/20.
//

import Foundation

class GetJson {
    static let decoder = JSONDecoder()

    static private func LoadWithFileName(fileName: String) -> Data {
        do {
            let path = Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            print("Unexpected error: \(error).")
        }

        return Data()
    }

    static func getCyphers() -> [ULCypher]? {
        let jsonObject = LoadWithFileName(fileName: "cyphers")
        return try? decoder.decode([ULCypher].self, from: jsonObject)
    }

    static func getAllianceUnits() -> [ULUnit]? {
        let jsonObject = LoadWithFileName(fileName: "units-alliance")
        return try? decoder.decode([ULUnit].self, from: jsonObject)
    }

    static func getContinuumUnits() -> [ULUnit]? {
        let jsonObject = LoadWithFileName(fileName: "units-continuum")
        return try? decoder.decode([ULUnit].self, from: jsonObject)
    }

    static func getMarchersUnits() -> [ULUnit]? {
        let jsonObject = LoadWithFileName(fileName: "units-marchers")
        return try? decoder.decode([ULUnit].self, from: jsonObject)
    }

    static func getHeros() -> [ULUnit]? {
        let jsonObject = LoadWithFileName(fileName: "heros")
        return try? decoder.decode([ULUnit].self, from: jsonObject)
    }

    static func getJacks() -> [ULJack]? {
        let jsonObject = LoadWithFileName(fileName: "jacks")
        return try? decoder.decode([ULJack].self, from: jsonObject)
    }

    static func getWeapons() -> [ULWeapon]? {
        let jsonObject = LoadWithFileName(fileName: "weapons")
        return try? decoder.decode([ULWeapon].self, from: jsonObject)
    }

    static func getRules() -> [ULRule]? {
        let jsonObject = LoadWithFileName(fileName: "rules")
        return try? decoder.decode([ULRule].self, from: jsonObject)
    }

    static func getCortex() -> [ULCortex]? {
        let jsonObject = LoadWithFileName(fileName: "cortex")
        return try? decoder.decode([ULCortex].self, from: jsonObject)
    }

    static func getFactions() -> [ULFaction]? {
        let jsonObject = LoadWithFileName(fileName: "factions")
        return try? decoder.decode([ULFaction].self, from: jsonObject)
    }
    
}
