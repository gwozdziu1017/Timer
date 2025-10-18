//
//  TimerModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//
import SwiftUI

enum TimerMode {
    case Work
    case Break
    case Precountdown
    case Finished
}

extension TimerMode {
    func getModeString() -> String {
        switch self {
        case .Work:
            return "Work"
        case .Break:
            return "Break"
        case .Precountdown:
            return "Precountdown"
        case .Finished:
            return "Finished"
        }
    }
}

class TimerModel: ObservableObject {
    var noOfRounds: Int
    var roundTime: Time
    var breakTime: Time
    var precountdownTime: Time
    var currentRound: Int
    var timerMode: TimerMode
    var remainingTime: Time

    init(tm: TimerModel) {
        self.noOfRounds = tm.noOfRounds
        self.roundTime = tm.roundTime
        self.breakTime = tm.breakTime
        self.precountdownTime = tm.precountdownTime
        self.currentRound = tm.currentRound
        self.timerMode = tm.timerMode
        self.remainingTime = tm.remainingTime
    }

    init(
        noOfRounds: Int,
        roundTime: Time,
        breakTime: Time,
        precountdownTime: Time,
        currentRound: Int = 0,
        timerMode: TimerMode,
        remainingTime: Time) {
            self.noOfRounds = noOfRounds
            self.roundTime = roundTime
            self.breakTime = breakTime
            self.precountdownTime = precountdownTime
            self.currentRound = currentRound
            self.timerMode = timerMode
            self.remainingTime = remainingTime
    }

    init() {
        self.noOfRounds = 5
        self.roundTime = Time(minutes: 5, seconds: 0)
        self.breakTime = Time(minutes: 1, seconds: 0)
        self.precountdownTime = Time(minutes: 0, seconds: 0)
        self.currentRound = 1
        self.timerMode = self.precountdownTime.toInt() > 0 ? .Precountdown :.Work
        self.remainingTime = 0.toTime()
        self.remainingTime = self.getRemainingTimeBasedOnMode()
    }

    func getInitialTime() -> Time {
        return self.precountdownTime.toInt() > 0 ? self.precountdownTime : self.roundTime
    }

    func setNoOfRounds(noOfRounds: Int) {
        self.noOfRounds = noOfRounds
    }

    func setRoundTime(roundTime: Time) {
        self.roundTime = roundTime
    }

    func setBreakTime(breakTime: Time) {
        self.breakTime = breakTime
    }

    func setPrecountdownTime(precountdownTime: Time) {
        self.precountdownTime = precountdownTime
    }

    func setTimerMode(_ mode: TimerMode) {
        self.timerMode = mode
    }

    func incrementCurrentRound() {
        self.currentRound += 1
    }

    func isLastRound() -> Bool {
        return currentRound == noOfRounds
    }

    func setTimerMode(mode: TimerMode) {
        self.timerMode = mode
    }
    func refreshTimerMode() {
        if self.precountdownTime.toInt() > 0 {
            self.setTimerMode(mode: .Precountdown)
        }
    }

    func switchTimerMode(isAfterLastRound: Bool = false) {
        if self.timerMode == .Work {
            if isAfterLastRound {
                self.setTimerMode(mode: .Finished)
            }
            else {
                self.setTimerMode(.Break)
            }
        }
        else if self.timerMode == .Break {
            self.setTimerMode(mode: .Work)
        }
        else if self.timerMode == .Precountdown {
            self.setTimerMode(mode: .Work)
        }
    }

    func getRemainingTimeBasedOnMode() -> Time {
        switch self.timerMode {
        case .Work:
            return self.roundTime
        case .Break:
            return self.breakTime
        case .Precountdown:
            return self.precountdownTime
        case .Finished:
            return Time(minutes: 0, seconds: 0)
        }
    }
}

extension TimerModel {
    func print() -> String {
        return "No of rounds: \(noOfRounds)\nRound time: \(roundTime.printable())\nBreak time: \(breakTime.printable())\nPrecountdown time: \(precountdownTime.printable())\nCurrent round: \(currentRound)"
    }
}
