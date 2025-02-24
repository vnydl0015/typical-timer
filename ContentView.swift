//
//  ContentView.swift
//  First Timer
//
//  Created by Vannyda Long on 11/2/2025.
//

import SwiftUI
import UIKit


struct ContentView: View {
    @State private var selectedHour = 0
    @State private var selectedMin = 0
    @State private var selectedSec = 0
    @State private var myGray = Color(red: 0.44, green: 0.44, blue: 0.46)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 60) {
                    HStack {
                        Button(action: {
                            // Handle back action
                        })
                        { Image(systemName: "arrow.left").padding()}
                        Spacer()
                        Text("TIMERS").bold().kerning(4)
                        Spacer()
                        Button(action: {
                            // Handle back action
                        })
                        { Image(systemName: "gear").padding()}
                    }
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    
                    HStack {
                        Text("HOURS").padding()
                        Spacer()
                        Text("MINUTES")
                        Spacer()
                        Text("SECONDS").padding()
                    }
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .font(.system(size: 12))
                    .kerning(2)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(myGray)
                        .offset(y: -50)
                    
                    HStack {
                        Picker("HOURS", selection: $selectedHour) {
                            ForEach(0...23, id: \.self) { hour in
                                Text(String(format: "%02d", hour))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Picker("MINUTES", selection: $selectedMin) {
                            ForEach(0...59, id: \.self) { min in
                                Text(String(format: "%02d", min))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Picker("SECONDS", selection: $selectedSec) {
                            ForEach(0...59, id: \.self) { sec in
                                Text(String(format: "%02d", sec))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .offset(y: -90)
                    
                    HStack {
                        Image(systemName: "bell.and.waves.left.and.right")
                        Text("Alarm").bold()
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .offset(y: -30)
                    
                    NavigationLink(destination: CircleTimerView(hours: selectedHour, mins: selectedMin, secs: selectedSec)) {
                        Text("START")
                            .padding(.horizontal, 100)
                            .padding(.vertical, 20)
                            .foregroundColor(.white)
                            .kerning(4)
                            .bold()
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(myGray, lineWidth: 3)
                            )
                    }
                    .offset(y: -20)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
