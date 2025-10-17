//
//  ContentView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerViewContent: View {
    @StateObject private var timerViewModel: TimerViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(timerModel: Binding<TimerModel>) {
        _timerViewModel = StateObject(wrappedValue: TimerViewModel(timerModel: timerModel))
    }
    
    var body: some View {
        VStack {
            timerViewModel.getTimerModeView()
            timerViewModel.getTimeView()
            timerViewModel.getCurrentRoundView()
            timerViewModel.getStartPauseStopButtonsView()
            timerViewModel.printTestingInfo()
        
            Spacer()
            timerViewModel.getSettingsButtonView()
                .sheet(isPresented: $timerViewModel.isPresented) {
                    TimerSettingsView(settings: $timerViewModel.timerModel)
                }
        }
        .onReceive(timer) { time in
            timerViewModel.onReceivingTimer(timer: time)
        }
    }
}


struct TimerView: View {
    @State private var timerModel: TimerModel = TimerModel()
    var body: some View {
        TimerViewContent(timerModel: $timerModel)
    }
}

#Preview {
    TimerView()
}
