//
//  ContentView.swift
//  Moonshot
//
//  Created by apple on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var crew = ""
    @State private var toggle = false

    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if !toggle {
                            Text(mission.formattedDate)
                                .font(.footnote)
                        } else {
                            Text(mission.stringCrew)
                                .font(.footnote)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: { toggle.toggle()}, label: {
                if !toggle {
                    Text("Crew")
                        .animation(.default)
                } else {
                    Text("Date")
                        .animation(.default)
                }
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
