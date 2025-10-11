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

    @State var timerModel: TimerModel = TimerModel()
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                timerViewModel.getTimerModeView()
                timerViewModel.getTimeView()
                timerViewModel.getCurrentRoundView()
                timerViewModel.getStartPauseStopButtonsView()
                
                VStack { // temporarily for testing
                    Text("\(timerModel.print())").foregroundStyle(.white)
                }
                Spacer()                
                timerViewModel.getSettingsButtonView()
                    .sheet(isPresented: $timerViewModel.isPresented) {
                        TimerSettingsView(settings: $timerModel)
                    }
            }
        }
        .onReceive(timer) { time in
            timerViewModel.onReceivingTimer(timer: time)
        }
    }
}

#Preview {
    TimerView(timerViewModel: .init(timerModel: .constant(TimerModel())))
}
