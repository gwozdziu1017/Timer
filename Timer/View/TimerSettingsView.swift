//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @ObservedObject var timerSettingsViewModel: TimerSettingsViewModel
    
    init(settings: Binding<TimerSettingsModel>) {
        timerSettingsViewModel = .init(settings: settings)
    }

    var body: some View {
        timerSettingsViewModel.getView()
    }
}

//#Preview {
//    TimerSettingsView()
//}
