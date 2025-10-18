//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @ObservedObject var timerSettingsViewModel: TimerSettingsViewModel
    
    init(timerViewModel: TimerViewModel) {
        timerSettingsViewModel = TimerSettingsViewModel(timerViewModel: timerViewModel)
    }

    var body: some View {
        timerSettingsViewModel.getView()
    }
}

//#Preview {
//    TimerSettingsView()
//}
