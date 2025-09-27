//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    @State private var isPrecountOn: Bool
    @State private var noOfRounds: Int
    @State private var roundTime: Time
    @State private var breakTime: Time
    @State private var precountdownTime: Time

    @Binding var timerSettingsModel: TimerSettingsModel

    init(settings: Binding<TimerSettingsModel>) {
        isPrecountOn = false
        noOfRounds = 1
        roundTime = .init(minutes: 3, seconds: 0)
        breakTime = .init(minutes: 1, seconds: 0)
        precountdownTime = .init(minutes: 0, seconds: 10)
        self._timerSettingsModel = settings
    }
    
    var body: some View {
        VStack {
            Text("Settings")
            //Spacer()
            VStack { // all properties
                VStack { // no of rounds
                    Text("Number of rounds:")
                    Picker("noofrounds", selection: $noOfRounds) {
                        ForEach(1..<51){elem  in
                            Text("\(elem)")
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                VStack { // length
                    Text("Work time:")
                    HStack {
                        Text("Minutes:")
                        Picker("min", selection: $roundTime.minutes) {
                            ForEach(1..<61){elem  in
                                Text("\(elem)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                        Text("Seconds:")
                        Picker("sec", selection: $roundTime.seconds) {
                            ForEach(1..<61){elem  in
                                Text("\(elem)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                    
                }
                VStack {
                    Text("Break time:")
                    Picker("breaktime", selection: $breakTime) {
                        // make it like 5 10 30 60 sec
                        ForEach(breakTimeArray, id:\.self){ elem  in
                            Text("\(elem.printSeconds())")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                VStack {// precount
                    Text("Precount:")
                    
                    Toggle("Precount", isOn: $isPrecountOn)
                    if isPrecountOn {
                        Picker("precount", selection: $precountdownTime) {
                            ForEach(precountdownTimeArray, id: \.self){ elem  in
                                Text("\(elem.printSeconds())")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                }
                HStack {
                    Button("Save") {
                        // TODO: if precountdown is off then value should be zero
                        timerSettingsModel.setNoOfRounds(noOfRounds: 777)
                        
                    } // button save
                }
            }
        }
    }
}

//#Preview {
//    TimerSettingsView()
//}
