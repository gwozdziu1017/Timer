//
//  TimerSettingsModel.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

struct Time: Equatable {
    var minutes: Int
    var seconds: Int

    init(minutes: Int, seconds: Int) {
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

/* TODO
enum PrecountdownTime: Time {
    case 0
    case 5
    case 10
    case 30
}
 */

struct TimerSettingsModel {
    var noOfRounds: Int
    var roundTime: Time
    var breakTime: Time
    var precountdownTime: Int

    init(
        noOfRounds: Int,
        roundTime: Time,
        breakTime: Time,
        precountdownTime: Int) {
            self.noOfRounds = noOfRounds
            self.roundTime = roundTime
            self.breakTime = breakTime
            self.precountdownTime = precountdownTime
    }

    init() {
        self.noOfRounds = 5
        self.roundTime = Time(minutes: 5, seconds: 0)
        self.breakTime = Time(minutes: 1, seconds: 0)
        self.precountdownTime = 10
    }

    mutating func setNoOfRounds(noOfRounds: Int) {
        self.noOfRounds = noOfRounds
    }

    mutating func setRoundTime(roundTime: Time) {
        self.roundTime = roundTime
    }

    mutating func setBreakTime(breakTime: Time) {
        self.breakTime = breakTime
    }

    mutating func setPrecountdownTime(precountdownTime: Int) {
        self.precountdownTime = precountdownTime
    }
}
