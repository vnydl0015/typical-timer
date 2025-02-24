//
//  CircleTimerView.swift
//  First Timer
//
//  Created by Vannyda Long on 11/2/2025.
//

import SwiftUI
import UIKit


struct CircleTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var hours: Int
    var mins: Int
    var secs: Int
    
    @State private var remainingTime: Int
    @State private var isRunning = true
    @State private var myGray = Color(red: 0.44, green: 0.44, blue: 0.46)
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(hours: Int, mins: Int, secs: Int) {
        self.hours = hours
        self.mins = mins
        self.secs = secs
        self._remainingTime = State(initialValue: (hours * 3600) + (mins * 60) + secs)
    }
    
    func formattedTime() -> String {
        let h = remainingTime / 3600
        let m = (remainingTime % 3600) / 60
        let s = remainingTime % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 60) {
            
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) { Image(systemName: "arrow.left").padding() }
                    Spacer()
                    Text("TIMING").bold().kerning(4)
                    Spacer()
                    Button(action: {
                        // Handle back action (if needed)
                    })
                    { Text("Edit").padding().font(.system(size: 15)) }
                }
                .padding(.horizontal)
                .foregroundColor(.white)
                
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(remainingTime) / CGFloat((hours * 3600) + (mins * 60) + secs))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                        .foregroundColor(myGray)
                        .animation(.linear(duration: 1), value: remainingTime)
                    
                }
                .frame(width: 250, height: 250)
                .onReceive(timer) { _ in
                    if isRunning && remainingTime > 0 {
                        remainingTime -= 1
                    }
                }
                
                Text("\(formattedTime())")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    isRunning = !isRunning
                            
                }) {
                    Text(isRunning ? "PAUSE" : "CONTINUE")
                        .padding(.horizontal, 100)
                        .padding(.vertical, 20)
                        .background(isRunning ? Color.black : myGray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(isRunning ? myGray : Color.white, lineWidth: 3)
                        )
                }
                
                Button(action: {
                    remainingTime = 0
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Reset")
                        .foregroundColor(myGray).font(.system(size: 15))
                }.offset(y:-20)

            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
