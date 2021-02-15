//
//  Misson.swift
//  Moonshot
//
//  Created by apple on 2/13/21.
//

import Foundation


let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedDate: String {
        if let launch = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launch)
        } else {
            return "N/A"
        }
    }

    public var stringCrew: String {
        var ans: String = ""
        for astronaut in astronauts {
            for crewMan in crew {
                if crewMan.name == astronaut.id {
                    ans += "\(astronaut.name), "
                }
            }
        }
        return ans
    }
}
