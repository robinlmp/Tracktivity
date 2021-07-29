//
//  ActivityView.swift
//  Tracktivity
//
//  Created by Robin Phillips on 25/06/2021.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activitiesClass: Activities
    var index: Int

    var body: some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, d MMM y"
        
        return VStack {
            if activitiesClass.activitiesArray.count > 0 {
                HStack {

                    VStack(alignment: .leading) {
                        Text(activitiesClass.activitiesArray[index].title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                        
                        Text(activitiesClass.activitiesArray[index].description)
                            .foregroundColor(Color.secondary)

                    }
                    .padding()
                    
                    Spacer()
                    
                    ZStack {
                        Button {
                            activitiesClass.activitiesArray[index].numberOfTimes += 1
                            activitiesClass.activitiesArray[index].dates.insert(Date(), at: 0)

                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .padding()
                        }
                        
                    }
                }
                .frame(height: 150, alignment: .center)
                Spacer()
                
                
                
            
            
            
            VStack(alignment: .leading) {
                HStack{
                    
                    Text("Number")
                        .fontWeight(.bold)
                        .frame(width: 100)
                    
                    Text("When")
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                .frame(maxWidth: .infinity)
                .frame(height: 0)
                .padding()
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 1)
                    .background(Color.primary)
                
                List (0..<(activitiesClass.activitiesArray[index].numberOfTimes + 0), id: \.self) { i in
                    
                    
                    HStack{
                        
                        Text(String(activitiesClass.activitiesArray[index].numberOfTimes - i))
                            .frame(width: 100)
                        
                        Text(dateFormatter.string(from: activitiesClass.activitiesArray[index].dates[i]))
                        
                    }
                    .onAppear() {
                        print("i is \(i)")
                        print("index is \(index)")
                    }
                    
                }
                
            }
            
            } else {
                Text("Please add an activity")
            }
            
            
        }
        .navigationTitle("Details")
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activitiesClass: .preview, index: 0)
    }
    
}
