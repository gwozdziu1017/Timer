//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @ObservedObject var tsvm: TimerSettingsViewModel
    
    init(settings: Binding<TimerSettingsModel>) {
        tsvm = .init(settings: settings)
    }
    
    var body: some View {
        tsvm.getView()
    }
}

//#Preview {
//    TimerSettingsView()
//}
