//
//  Updater.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import Foundation
import Combine
import os

class Updater: ObservableObject {
    let logger = Logger(subsystem: "VoidBarracks", category: "Updater")
    let decoder = JSONDecoder()
    @Published var updateAvailable: Bool = false

    init() {}

    public func Check(_ storeLastUpdated: Date) {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/wartracker-v1.appspot.com/o/current%2Fcyphers.json")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                let file = try! self.decoder.decode([String:String].self, from: data)
                let fileLastUpdatedIso = file["updated"]!

                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let fileLastUpdate = dateFormatter.date(from: fileLastUpdatedIso)!

                self.logger.debug("File:\(fileLastUpdatedIso) Store:\(storeLastUpdated)")
                self.updateAvailable = fileLastUpdate > storeLastUpdated


                if self.updateAvailable {
                    self.logger.notice("There is an update available.")
                } else {
                    self.logger.notice("There is NO UPDATE available.")
                }
            }
        }.resume()
    }
}
