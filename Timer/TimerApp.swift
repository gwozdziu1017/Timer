//
//  TimerApp.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

@main
struct TimerApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(timerViewModel: .init(timerModel: .constant(.init())))
        }
    }
}
