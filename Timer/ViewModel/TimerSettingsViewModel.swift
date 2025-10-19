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
        Button {
            self.timerViewModel.timerModel.refreshTimerMode()
            self.timerViewModel.resetRemainingTime()
            
            if self.timerViewModel.timerModel.timerMode == .Finished {
                self.timerViewModel.resetTimer()
            }

            self.timerViewModel.setStartPauseStopButtonsDisabled(
                startButtonDisabled: false,
                pauseButtonDisabled: true,
                stopButtonDisabled: true
            )
            self.timerViewModel.isPresented = false
        } label: {
            Text("Save")
                .font(.system(size: 20, weight: .bold))
                .bold()
        }
    }

    func getNumberOfRoundsView() -> some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Text("Number of Rounds")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Picker("", selection: timerViewModel.$timerModel.noOfRounds) {
                    ForEach(minRoundNumber...maxRoundNumber, id: \.self) { elem in
                        Text("\(elem)")
                            .tag(elem)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 100)
            }
            .padding(.vertical, 5)
        }
    }

    func getWorkTimeView() -> some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Text("Work Time")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Minutes")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Picker("", selection: timerViewModel.$timerModel.roundTime.minutes) {
                            ForEach(minTimeMinute...maxTimeMinute, id: \.self) { elem in
                                Text("\(elem)")
                                    .tag(elem)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                    }

                    VStack(alignment: .leading) {
                        Text("Seconds")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Picker("", selection: timerViewModel.$timerModel.roundTime.seconds) {
                            ForEach(minTimeSecond...maxTimeSecond, id: \.self) { elem in
                                Text("\(elem)")
                                    .tag(elem)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                    }
                }
            }
            .padding(.vertical, 5)
        }
    }

    func getBreakTimeView() -> some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Text("Break Time")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Picker("", selection: timerViewModel.$timerModel.breakTime) {
                    ForEach(breakTimeArray, id: \.self) { elem in
                        Text("\(elem.printInSeconds())")
                            .tag(elem)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.vertical, 5)
        }
    }

    func getPrecountOnView() -> some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Text("Precount")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Picker("", selection: timerViewModel.$timerModel.precountdownTime) {
                    ForEach(precountdownTimeArray, id: \.self) { elem in
                        Text("\(elem.printInSeconds())")
                            .tag(elem)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    TimerSettingsView(timerViewModel: TimerViewModel(timerModel: .constant(TimerModel())))
}
