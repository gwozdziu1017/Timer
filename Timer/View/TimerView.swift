//
//  ContentView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerViewContent: View {
    @ObservedObject var timerViewModel: TimerViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            timerViewModel.backgroundColor
            
            VStack(spacing: 5) {
                timerViewModel.getTimerModeView()
                timerViewModel.getCurrentRoundView()
                timerViewModel.getTimeView()
                timerViewModel.getStartPauseStopButtonsView()
                
                Spacer()
                timerViewModel.getSettingsButtonView()
                    .sheet(isPresented: $timerViewModel.isPresented) {
                        TimerSettingsView(timerViewModel: timerViewModel)
                    }
            }
            .padding()
        }
        .onReceive(timer) { time in
            timerViewModel.onReceivingTimer(timer: time)
        }
    }
}

struct TimerView: View {
    @StateObject private var timerViewModel = TimerViewModel(timerModel: .constant(TimerModel()))
    
    var body: some View {
        TimerViewContent(timerViewModel: timerViewModel)
    }
}

#Preview {
    TimerView()
}
