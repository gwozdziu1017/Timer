import SwiftUI

class TimerViewModel: ObservableObject {
    @Binding var timerModel: TimerModel

    @Published public var isActive: Bool
    @Published public var isPaused: Bool
    @Published public var isPresented: Bool
    @Published public var timeRemaining: Int

    @Published private var isStartButtonDisabled: Bool
    @Published private var isPauseButtonDisabled: Bool
    @Published private var isStopButtonDisabled: Bool

    var runNextRound = true
    var needToIncrementRound = false

    init(timerModel: Binding<TimerModel>) {
        self._timerModel = timerModel
        
        self.isActive = false
        self.isPaused = false
        self.isPresented = false
        // Tu jest zmiana - od razu bierzemy precountdownTime jeśli jest większy od 0
        self.timeRemaining = timerModel.wrappedValue.precountdownTime.toInt() > 0
            ? timerModel.wrappedValue.precountdownTime.toInt()
            : timerModel.wrappedValue.getRemainingTimeBasedOnMode().toInt()
        
        //self.timeRemaining = timerModel.wrappedValue.getRemainingTimeBasedOnMode().toInt()

        self.isStartButtonDisabled = false
        self.isPauseButtonDisabled = true
        self.isStopButtonDisabled = true
    }

    func printTestingInfo() -> some View {
        VStack {
            Text("noOfRounds: \(self.timerModel.noOfRounds)")
            Text("roundTime: \(self.timerModel.roundTime)")
            Text("breakTime: \(self.timerModel.breakTime)")
            Text("precountdownTime: \(self.timerModel.precountdownTime)")
            Text("currentRound: \(self.timerModel.currentRound)")
            Text("timerMode: \(self.timerModel.timerMode)")
        }
    }

    func setStartPauseStopButtonsDisabled(startButtonDisabled: Bool, pauseButtonDisabled: Bool, stopButtonDisabled: Bool) {
        self.isStartButtonDisabled = startButtonDisabled
        self.isPauseButtonDisabled = pauseButtonDisabled
        self.isStopButtonDisabled = stopButtonDisabled
    }

    func getStartPauseStopButtonsView() -> some View {
        HStack {
            Button("Start") {
                self.isActive = true
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: true,
                    pauseButtonDisabled: false,
                    stopButtonDisabled: false)
            }.disabled(self.isStartButtonDisabled)

            Button("Pause") {
                self.isActive = false
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: false)
            }.disabled(self.isPauseButtonDisabled)

            Button("Stop") {
                self.timeRemaining = self.timerModel.getInitialTime().toInt()
                self.isActive = false
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: true)
            }.disabled(self.isStopButtonDisabled)
        }
    }

    func getSettingsButtonView() -> some View {
        Button("Settings") {
            self.isPresented.toggle()
        }
        .background(Color.green)
    }

    func onReceivingTimer(timer: Date) {
        guard self.isActive else { return }

        /*
         if self.timeRemaining > 0 {
             self.timeRemaining -= 1
         */
        if self.timerModel.timerMode == .Break && self.timeRemaining == 0 {
            self.needToIncrementRound = true
        }
        
        if self.timerModel.precountdownTime.toInt() == 0 {
            self.timerModel.setTimerMode(mode: .Work)
        }

        
        if runNextRound {
            // run timer till 0
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            else {
                self.timerModel.switchTimerMode()
                self.timeRemaining = self.timerModel.getRemainingTimeBasedOnMode().toInt()
            }
            if self.needToIncrementRound {
                self.timerModel.incrementCurrentRound()
                self.needToIncrementRound = false
            }
            runNextRound = self.timerModel.currentRound <= self.timerModel.noOfRounds
        }
        else {
            self.timerModel.switchTimerMode(isAfterLastRound: true)
            self.timeRemaining = self.timerModel.getRemainingTimeBasedOnMode().toInt()
            self.isActive = false
        }
//        if self.timeRemaining > 0 {
//            self.timeRemaining -= 1
//        }
//        else { // timeRemaining == 0
//            /* TODO: LOGIC */
//            self.isActive = false
//        }
    }

    func runTimer(timer: Date) {
        if self.timerModel.precountdownTime.toInt() == 0 {
            self.timerModel.setTimerMode(mode: .Work)
        }

        
        while runNextRound {
            // run timer till 0
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            else {
                self.timerModel.switchTimerMode()
                self.timeRemaining = self.timerModel.getRemainingTimeBasedOnMode().toInt()
            }
            runNextRound = self.timerModel.currentRound <= self.timerModel.noOfRounds
        }
        self.timerModel.switchTimerMode(isAfterLastRound: true)
        self.timeRemaining = self.timerModel.getRemainingTimeBasedOnMode().toInt()
        self.isActive = false
    }

    func getTimeView() -> some View {
        Text("Remaining\n\(self.timeRemaining.toTime().printable())")
            .font(.system(size: 30, design: .monospaced))
            .foregroundStyle(.green)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }

    func getTimerModeView() -> some View {
        Text(timerModel.timerMode.getModeString())
            .font(.system(size: 30, design: .monospaced))
            .foregroundStyle(.green)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }

    func getCurrentRoundView() -> some View {
        Text("Round: \(self.timerModel.currentRound) of \(self.timerModel.noOfRounds)")
            .font(.system(size: 30, design: .monospaced))
            .foregroundStyle(.green)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }

    func refreshRemainingTime() {
        if timerModel.precountdownTime.toInt() > 0 {
            timeRemaining = timerModel.precountdownTime.toInt()
        } else {
            timeRemaining = timerModel.getRemainingTimeBasedOnMode().toInt()
        }
    }

//    func resetTime() {
//        self.timeRemaining = self.timerModel.roundTime
//        self.isActive = false
//    }

}

#Preview {
    TimerView()
}
