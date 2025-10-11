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
        }
    }
}

class TimerModel: ObservableObject {
    var noOfRounds: Int
    var roundTime: Time
    var breakTime: Time
    var precountdownTime: Time
    var isPrecountOn: Bool
    var currentRound: Int
    var timerMode: TimerMode = .Work // TODO: move to init

    init(tm: TimerModel) {
        self.noOfRounds = tm.noOfRounds
        self.roundTime = tm.roundTime
        self.breakTime = tm.breakTime
        self.precountdownTime = tm.precountdownTime
        self.isPrecountOn = tm.isPrecountOn
        self.currentRound = tm.currentRound
    }

    init(
        noOfRounds: Int,
        roundTime: Time,
        breakTime: Time,
        precountdownTime: Time,
        isPrecountOn: Bool = false,
        currentRound: Int = 0) {
            self.noOfRounds = noOfRounds
            self.roundTime = roundTime
            self.breakTime = breakTime
            self.precountdownTime = precountdownTime
            self.isPrecountOn = isPrecountOn
            self.currentRound = currentRound
    }

    init() {
        self.noOfRounds = 5
        self.roundTime = Time(minutes: 5, seconds: 0)
        self.breakTime = Time(minutes: 1, seconds: 0)
        self.precountdownTime = Time(minutes: 0, seconds: 10)
        self.isPrecountOn = false
        self.currentRound = 1
    }

    func getInitialTime() -> Time {
        if self.isPrecountOn {
            return self.precountdownTime
        }
        else {
            return self.roundTime
        }
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

    func switchTimerMode() {
        if self.timerMode == .Work {
            self.timerMode = .Break
        }
        else if self.timerMode == .Break {
            self.timerMode = .Work
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
        }
    }
}

extension TimerModel {
    func print() -> String {
        return "No of rounds: \(noOfRounds)\nRound time: \(roundTime.printable())\nBreak time: \(breakTime.printable())\nPrecountdown time: \(precountdownTime.printable())\nCurrent round: \(currentRound)"
    }
}
