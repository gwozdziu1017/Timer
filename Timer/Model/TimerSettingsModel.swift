//
//  TimerSettingsModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//
import SwiftUI

struct Time: Equatable, Hashable {
    var minutes: Int
    var seconds: Int

    init(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
    init() {
        self.minutes = 0
        self.seconds = 0
    }

    mutating func setTime(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
    func convertTimeToInt(time: Time) -> Int {
        return 60 * time.minutes + time.seconds
    }
    func convertTimeToInt() -> Int {
        return 60 * self.minutes + self.seconds
    }
    func getMinutesFromInt(timeAsInt: Int) -> Int{
        return Int(timeAsInt/60)
    }
    func getSecondsFromInt(timeAsInt: Int) -> Int {
        return timeAsInt % 60
    }
    func convertToTime(timeAsInt: Int) -> Time {
        return Time(minutes: getMinutesFromInt(timeAsInt: timeAsInt), seconds: getSecondsFromInt(timeAsInt: timeAsInt))
    }
}

extension Time {
    func printSeconds() -> String {
        return "\(seconds)" + " sec"
    }
    func printable() -> String {
        return "\(minutes) min :\(seconds) sec"
    }
    func get() -> Time {
        return self
    }
    func toInt() -> Int {
        return convertTimeToInt(time: self)
    }
}

extension Int {
    func toTime() -> Time {
        let minutes: Int = self / 60
        let seconds: Int = self % 60
        return Time(minutes: minutes, seconds: seconds)
    }
}

let breakTimeArray: [Time] = [
    Time(minutes: 0, seconds: 5),
    Time(minutes: 0, seconds: 30),
    Time(minutes: 0, seconds: 60)
]

let precountdownTimeArray: [Time] = [
    Time(minutes: 0, seconds: 5),
    Time(minutes: 0, seconds: 10),
    Time(minutes: 0, seconds: 30)]

let minRoundNumber: Int = 1
let maxRoundNumber: Int = 30

let minTimeMinute: Int = 0
let maxTimeMinute: Int = 20

let minTimeSecond: Int = 0
let maxTimeSecond: Int = 59
