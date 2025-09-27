//
//  ContentView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true

    @State private var isPresented: Bool = false
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var settings: TimerSettingsModel = TimerSettingsModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.system(size: 60, design: .monospaced))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                HStack {
                    Button("Start") {
                        isActive = true
                    }//.disabled(disabled: true)
                    Button("Pause") {
                        isActive = false
                    }
                    Button("Stop") {
                        timeRemaining = 100
                        isActive = false
                    }
                }
                VStack { // temporarily for testing
                    Text("\(settings.print())").foregroundStyle(.white)
                }
                Spacer()
                Button("Settings") {
                    isPresented.toggle()
                }
                .background(Color.green)
                .sheet(isPresented: $isPresented) {
                    TimerSettingsView(settings: $settings)
                }
            }

        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
    }
}

#Preview {
    TimerView()
}
