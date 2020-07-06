//
//  Getters.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/29/20.
//

import Foundation

class GetJson: ObservableObject {
    let decoder = JSONDecoder()
    @Published var cortex: [ULCortex] = []
    @Published var cyphers: [ULCypher] = []
    @Published var allianceUnits: [ULUnit] = []
    @Published var continuumUnits: [ULUnit] = []
    @Published var marcherUnits: [ULUnit] = []
    @Published var heros: [ULUnit] = []
    @Published var jacks: [ULJack] = []
    @Published var weapons: [ULWeapon] = []
    @Published var rules: [ULRule] = []
    @Published var factions: [ULFaction] = []

    init() {
        loadCyphers()
        loadAlliance()
        loadContinuum()
        loadMarchers()
        loadHeros()
        loadJacks()
        loadWeapons()
        loadRules()
        loadCortex()
        loadFactions()
    }

    private func loadCyphers() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Fcyphers.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.cyphers = try! self.decoder.decode([ULCypher].self, from: data)
            }
        }.resume()
    }

    private func loadCortex() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Fcortex.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.cortex = try! self.decoder.decode([ULCortex].self, from: data)
            }
        }.resume()
    }

    private func loadAlliance() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Funits-alliance.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.allianceUnits = try! self.decoder.decode([ULUnit].self, from: data)
            }
        }.resume()
    }

    private func loadContinuum() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Funits-continuum.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.continuumUnits = try! self.decoder.decode([ULUnit].self, from: data)
            }
        }.resume()
    }

    private func loadMarchers() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Funits-marchers.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.marcherUnits = try! self.decoder.decode([ULUnit].self, from: data)
            }
        }.resume()
    }

    private func loadHeros() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Fheros.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.heros = try! self.decoder.decode([ULUnit].self, from: data)
            }
        }.resume()
    }

    private func loadJacks() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Fjacks.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.jacks = try! self.decoder.decode([ULJack].self, from: data)
            }
        }.resume()
    }

    private func loadWeapons() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Fweapons.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.weapons = try! self.decoder.decode([ULWeapon].self, from: data)
            }
        }.resume()
    }

    private func loadRules() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Frules.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.rules = try! self.decoder.decode([ULRule].self, from: data)
            }
        }.resume()
    }
    private func loadFactions() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Ffactions.json?alt=media")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                self.factions = try! self.decoder.decode([ULFaction].self, from: data)
            }
        }.resume()
    }
    
}
