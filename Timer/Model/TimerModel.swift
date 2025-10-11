//
//  TimerModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//
import SwiftUI

class TimerModel: ObservableObject {
    var noOfRounds: Int
    var roundTime: Time
    var breakTime: Time
    var precountdownTime: Time
    var isPrecountOn: Bool

    init(tm: TimerModel) {
        self.noOfRounds = tm.noOfRounds
        self.roundTime = tm.roundTime
        self.breakTime = tm.breakTime
        self.precountdownTime = tm.precountdownTime
        self.isPrecountOn = tm.isPrecountOn
    }

    init(
        noOfRounds: Int,
        roundTime: Time,
        breakTime: Time,
        precountdownTime: Time,
        isPrecountOn: Bool = false) {
            self.noOfRounds = noOfRounds
            self.roundTime = roundTime
            self.breakTime = breakTime
            self.precountdownTime = precountdownTime
            self.isPrecountOn = isPrecountOn
    }

    init() {
        self.noOfRounds = 5
        self.roundTime = Time(minutes: 5, seconds: 0)
        self.breakTime = Time(minutes: 1, seconds: 0)
        self.precountdownTime = Time(minutes: 0, seconds: 10)
        self.isPrecountOn = false
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
}

extension TimerModel {
    func print() -> String {
        return "No of rounds: \(noOfRounds)\nRound time: \(roundTime.print())\nBreak time: \(breakTime.print())\nPrecountdown time: \(precountdownTime.print())"
    }
}
