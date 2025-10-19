//
//  TimerSettingsViewModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 30/09/2025.
//

import SwiftUI

class TimerSettingsViewModel: ObservableObject {
    @ObservedObject var timerViewModel: TimerViewModel

    init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }

    func getSaveButtonView() -> some View {
        HStack {
            Button("Save") {
                self.timerViewModel.timerModel.refreshTimerMode()
                self.timerViewModel.resetRemainingTime()

                if self.timerViewModel.timerModel.timerMode == .Finished {
                    self.timerViewModel.resetTimer()
                }
                self.timerViewModel.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: true)
                self.timerViewModel.isPresented = false
            }
        }
    }

    func getNumberOfRoundsView() -> some View {
        VStack {
            Text("Number of rounds:")
            Picker("noofrounds", selection: timerViewModel.$timerModel.noOfRounds) {
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
                Picker("min", selection: timerViewModel.$timerModel.roundTime.minutes) {
                    ForEach(minTimeMinute...maxTimeMinute, id: \.self) {elem  in
                        Text("\(elem)")
                    }
                }.pickerStyle(WheelPickerStyle())
                Text("Seconds:")
                Picker("sec", selection: timerViewModel.$timerModel.roundTime.seconds) {
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
            Picker("breaktime", selection: timerViewModel.$timerModel.breakTime) {
                ForEach(breakTimeArray, id:\.self) { elem  in
                    Text("\(elem.printInSeconds())")
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }

    func getPrecountOnView() -> some View {
        VStack {
            Text("Precount: ")
            Picker("precount", selection: timerViewModel.$timerModel.precountdownTime) {
                ForEach(precountdownTimeArray, id:\.self) { elem  in
                    Text("\(elem.printInSeconds())")
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}
