//
//  AstronautView.swift
//  Moonshot
//
//  Created by apple on 2/14/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var involvedInMissions = [String]()
    @State private var display = ""
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width)
                    Text("Missions: \(display)")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                    Text(astronaut.description)
                        .padding()
                }
            }
            .onAppear() {
                getMissions(astronaut.id)
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    func getMissions(_ id: String) {
        for mission in missions {
            for crewRole in mission.crew {
                if crewRole.name == id {
                    involvedInMissions.append(mission.displayName)
                }
            }
        }
        for mission in involvedInMissions {
            if involvedInMissions.count > 1 {
                display += "\(mission), "
            } else {
                display = mission
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
