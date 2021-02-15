//
//  MissionView.swift
//  Moonshot
//
//  Created by apple on 2/14/21.
//

import SwiftUI

struct MissionView: View {
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing that name")
            }
        }
        self.astronauts = matches
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width*0.75)
                        .padding(.top)
            
                    Text(mission.description)
                            .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle()
                                                .stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    if crewMember.role != "Commander" && crewMember.role != "Command Pilot" {
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    } else {
                                        Text(crewMember.role)
                                            .foregroundColor(.red)
                                    }
                                }
                                Spacer()
                            }
                            
                            Spacer(minLength: 25)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle(Text(mission.displayName), displayMode: .inline )
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}
