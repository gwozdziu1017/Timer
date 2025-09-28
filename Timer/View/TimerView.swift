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
    @ObservedObject var tvm: TimerViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                tvm.getTimeView()
                tvm.getStartPauseStopButtonsView()
                
                VStack { // temporarily for testing
                    Text("\(settings.print())").foregroundStyle(.white)
                }
                Spacer()
                
                tvm.getSettingsButtonView()
                    .sheet(isPresented: $tvm.isPresented) {
                        TimerSettingsView(settings: $settings)
                    }
            }
        }
        .onReceive(timer) { time in
            tvm.onReceivingTimer(timer: time)
        }
        .onChange(of: scenePhase) {
            tvm.onChange(scenePhase: scenePhase)
        }
    }
}

#Preview {
    TimerView(tvm: .init())
}
