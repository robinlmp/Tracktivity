//
//  ContentView.swift
//  Tracktivity
//
//  Created by Robin Phillips on 23/06/2021.
//

import SwiftUI

class Activities: ObservableObject {
    @Published var activitiesArray = [Activity]() {
    
    didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activitiesArray) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    static let preview: Activities = {
      // make an example version for previews
      let activitiesClass = Activities()
        activitiesClass.activitiesArray.append(Activity(title: "example", description: "this is an example activity", numberOfTimes: 1, dates: [Date()], id: UUID()))
      return activitiesClass
    }()
    
    init() {
        if let activitiesArray = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activitiesArray) {
                self.activitiesArray = decoded
                return
            }
        }

        self.activitiesArray = []
    }
}

struct Activity: Identifiable, Codable {
    var title: String
    var description: String
    var numberOfTimes: Int
    var dates: [Date]
    var id: UUID
}



struct ContentView: View {
    @StateObject var activitiesClass = Activities()
    
    @State private var showSheet = false
    
    @State private var tempTitle: String = ""
    @State private var tempDescription: String = ""
    
    var body: some View {
        
        
        
        NavigationView {
            
            VStack {
                
                if activitiesClass.activitiesArray.count == 0 {
                    VStack {
                        Spacer()

                        Text("Please add an activity")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                        
                        //Spacer()
                        Button {
                            showSheet.toggle()
                            
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .frame(width: 125, height: 125)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding(50)
                        }
                        Spacer()
                    }
                    
                } else {
                    
                }
                
                List {
                    ForEach (activitiesClass.activitiesArray.indices, id: \.self) { i in
                        NavigationLink(activitiesClass.activitiesArray[i].title, destination: ActivityView(activitiesClass: activitiesClass, index: i) )
                    }
                    .onDelete(perform: removeItems)
                }
                
                
            }
            .navigationBarTitle(Text("Tracktivity"))
            .navigationBarItems(trailing: Button("Add activity"){
                showSheet.toggle()
            })
            

            .sheet(isPresented: $showSheet, content: {
                
                Spacer()
                Form(content: {
                    
                    Section(header: Text("Add new activity").font(.title).fontWeight(.bold).foregroundColor(.primary).padding([.top, .bottom])) {
                        TextField("Activity", text: $tempTitle)
                        
                        TextField("Description", text: $tempDescription)
                    }
                    .textCase(.none)
                    
                    Button {
                        activitiesClass.activitiesArray.append(Activity(title: tempTitle, description: tempDescription, numberOfTimes: 0, dates: [Date()], id: UUID()))
                        
                        tempTitle = ""
                        tempDescription = ""
                        
                        showSheet.toggle()
                        
                    } label: {
                        Text("Add activity")
                            .fontWeight(.bold)
                    }
                    .keyboardType(.default)
                })
                
            })
            
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        activitiesClass.activitiesArray.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
