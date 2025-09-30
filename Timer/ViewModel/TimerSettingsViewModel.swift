//
//  TimerSettingsViewModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 30/09/2025.
//

import SwiftUI

class TimerSettingsViewModel: ObservableObject {
    @Binding var timerSettingsModel: TimerSettingsModel

    init(settings: Binding<TimerSettingsModel>) {
        self._timerSettingsModel = settings
    }
    
    func getNumberOfRoundsView() -> some View {
        VStack {
            Text("Number of rounds:")
            Picker("noofrounds", selection: $timerSettingsModel.noOfRounds) {
                ForEach(minRoundNumber...maxRoundNumber, id: \.self) {elem  in
                    Text("\(elem)")
                }
            }.pickerStyle(WheelPickerStyle())
            
        }
    }

    func getWorkTimeView() -> some View {
        VStack {
            Text("Work time:")
            HStack {
                Text("Minutes:")
                Picker("min", selection: $timerSettingsModel.roundTime.minutes) {
                    ForEach(minTimeMinute...maxTimeMinute, id: \.self) {elem  in
                        Text("\(elem)")
                    }
                }.pickerStyle(WheelPickerStyle())
                Text("Seconds:")
                Picker("sec", selection: $timerSettingsModel.roundTime.seconds) {
                    ForEach(minTimeSecond...maxTimeSecond, id: \.self) {elem  in
                        Text("\(elem)")
                    }
                }.pickerStyle(WheelPickerStyle())
            }
        }
    }

    func getBreakTimeView() -> some View {
        VStack {
            Text("Break time:")
            Picker("breaktime", selection: $timerSettingsModel.breakTime) {
                ForEach(breakTimeArray, id:\.self) { elem  in
                    Text("\(elem.printSeconds())")
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }

    func getPrecountOnView() -> some View {
        VStack {
            Text("Precount:")
            Toggle("Precount", isOn: $timerSettingsModel.isPrecountOn)
            if timerSettingsModel.isPrecountOn {
                Picker("precount", selection: $timerSettingsModel.precountdownTime) {
                    ForEach(precountdownTimeArray, id: \.self){ elem  in
                        Text("\(elem.printSeconds())")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
    
    func getSaveButtonView() -> some View {
        HStack {
            Button("Save") {
                if self.timerSettingsModel.isPrecountOn == false {
                    self.timerSettingsModel.precountdownTime = Time(minutes: 0, seconds: 0)
                }
            }
        }
    }

    func getView() -> some View {
        VStack {
            Text("Settings")
            //Spacer()
            VStack {
                getNumberOfRoundsView()
                getWorkTimeView()
                getBreakTimeView()
                getPrecountOnView()
                getSaveButtonView()
            }
        }
        
    }
}
