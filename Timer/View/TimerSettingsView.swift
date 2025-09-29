//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @State private var isPrecountOn: Bool

    @State private var temporarySettings: TimerSettingsModel = .init()
    @Binding var timerSettingsModel: TimerSettingsModel

    init(settings: Binding<TimerSettingsModel>) {
        isPrecountOn = false
        self._timerSettingsModel = settings
    }
    
    var body: some View {
        VStack {
            Text("Settings")
            //Spacer()
            VStack {
                VStack {
                    Text("Number of rounds:")
                    Picker("noofrounds", selection: $temporarySettings.noOfRounds) {
                        ForEach(minRoundNumber..<maxRoundNumber, id: \.self) {elem  in
                            Text("\(elem)")
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                VStack {
                    Text("Work time:")
                    HStack {
                        Text("Minutes:")
                        Picker("min", selection: $temporarySettings.roundTime.minutes) {
                            ForEach(minTimeMinute..<maxTimeMinute, id: \.self) {elem  in
                                Text("\(elem)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                        Text("Seconds:")
                        Picker("sec", selection: $temporarySettings.roundTime.seconds) {
                            ForEach(minTimeSecond..<maxTimeSecond, id: \.self) {elem  in
                                Text("\(elem)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                }
                VStack {
                    Text("Break time:")
                    Picker("breaktime", selection: $temporarySettings.breakTime) {
                        ForEach(breakTimeArray, id:\.self) { elem  in
                            Text("\(elem.printSeconds())")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                VStack {
                    Text("Precount:")
                    Toggle("Precount", isOn: $isPrecountOn)
                    if isPrecountOn {
                        Picker("precount", selection: $temporarySettings.precountdownTime) {
                            ForEach(precountdownTimeArray, id: \.self){ elem  in
                                Text("\(elem.printSeconds())")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                HStack {
                    Button("Save") {
                        if isPrecountOn == false {
                            temporarySettings.precountdownTime = Time(minutes: 0, seconds: 0)
                        }
                        timerSettingsModel = temporarySettings
                    }
                }
            }
        }
    }
}

//#Preview {
//    TimerSettingsView()
//}
