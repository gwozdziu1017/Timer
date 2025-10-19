//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @StateObject private var timerSettingsViewModel: TimerSettingsViewModel
    
    init(timerViewModel: TimerViewModel) {
        _timerSettingsViewModel = StateObject(wrappedValue: TimerSettingsViewModel(timerViewModel: timerViewModel))
    }
    
    var body: some View {
        TimerSettingsContent(timerSettingsViewModel: timerSettingsViewModel)
    }
}

struct TimerSettingsContent: View {
    @ObservedObject var timerSettingsViewModel: TimerSettingsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 30) {
                timerSettingsViewModel.getNumberOfRoundsView()
                timerSettingsViewModel.getWorkTimeView()
                timerSettingsViewModel.getBreakTimeView()
                timerSettingsViewModel.getPrecountOnView()
                timerSettingsViewModel.getSaveButtonView()
            }
            .padding()
        }
    }
}
#Preview {
    TimerSettingsView(timerViewModel: TimerViewModel(timerModel: .constant(TimerModel())))
}


