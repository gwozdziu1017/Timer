//
//  ContentView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.scenePhase) var scenePhase
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var settings: TimerSettingsModel = TimerSettingsModel()
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                timerViewModel.getTimeView()
                timerViewModel.getStartPauseStopButtonsView()
                
                VStack { // temporarily for testing
                    Text("\(settings.print())").foregroundStyle(.white)
                }
                Spacer()                
                timerViewModel.getSettingsButtonView()
                    .sheet(isPresented: $timerViewModel.isPresented) {
                        TimerSettingsView(settings: $settings)
                    }
            }
        }
        .onReceive(timer) { time in
            timerViewModel.onReceivingTimer(timer: time)
        }
        .onChange(of: scenePhase) {
            timerViewModel.onChange(scenePhase: scenePhase)
        }
    }
}

#Preview {
    TimerView(timerViewModel: .init())
}
