//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @ObservedObject var timerSettingsViewModel: TimerSettingsViewModel
    
    init(settings: Binding<TimerModel>) {
        timerSettingsViewModel = .init(timerViewModel: settings)
    }

    var body: some View {
        timerSettingsViewModel.getView()
    }
}

//#Preview {
//    TimerSettingsView()
//}
