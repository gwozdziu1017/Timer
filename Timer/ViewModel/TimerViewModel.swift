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

    private var runNextRound = true
    private var needToIncrementRound = false

    init(timerModel: Binding<TimerModel>) {
        self._timerModel = timerModel

        self.isActive = false
        self.isPaused = false
        self.isPresented = false
        self.timeRemaining = timerModel.wrappedValue.precountdownTime.toInt() > 0
        ? timerModel.wrappedValue.precountdownTime.toInt()
        : timerModel.wrappedValue.getRemainingTimeBasedOnMode().toInt()

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
                self.resetTimer()
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: true)
            }.disabled(self.isStopButtonDisabled)
        }
    }

    func resetTimer() {
        if self.timerModel.precountdownTime.toInt() > 0 {
            self.timerModel.setTimerMode(mode: .Precountdown)
        }
        else {
            self.timerModel.setTimerMode(mode: .Work)
        }
        self.timerModel.currentRound = 1
        self.timeRemaining = self.timerModel.getRemainingTimeBasedOnMode().toInt()
        self.isActive = false
    }

    func getSettingsButtonView() -> some View {
        Button("Settings") {
            self.isPresented.toggle()
        }
        .background(Color.green)
    }

    func onReceivingTimer(timer: Date) {
        guard isActive else { return }
        
        if shouldFinishLastRound {
            handleLastRound()
            return
        }
        
        handleBreakTimeEnd()
        handlePrecountdownEnd()
        
        if runNextRound {
            handleRunningRound()
        } else {
            handleTimerCompletion()
        }
    }

    private var shouldFinishLastRound: Bool {
        timerModel.timerMode == .Work &&
        timeRemaining == 1 &&
        timerModel.currentRound == timerModel.noOfRounds
    }

    private func handleLastRound() {
        timerModel.switchTimerMode(isAfterLastRound: true)
        timeRemaining = timerModel.getRemainingTimeBasedOnMode().toInt()
        isActive = false
        setStartPauseStopButtonsDisabled(
            startButtonDisabled: true,
            pauseButtonDisabled: true,
            stopButtonDisabled: true
        )
    }

    private func handleBreakTimeEnd() {
        if timerModel.timerMode == .Break && timeRemaining == 1 {
            needToIncrementRound = true
        }
    }

    private func handlePrecountdownEnd() {
        if timerModel.precountdownTime.toInt() == 1 {
            timerModel.setTimerMode(mode: .Work)
        }
    }

    private func handleRunningRound() {
        if timeRemaining > 1 {
            timeRemaining -= 1
        } else {
            switchToNextMode()
        }
        
        updateRoundIfNeeded()
        checkIfShouldContinue()
    }

    private func switchToNextMode() {
        timerModel.switchTimerMode()
        timeRemaining = timerModel.getRemainingTimeBasedOnMode().toInt()
    }

    private func updateRoundIfNeeded() {
        if needToIncrementRound {
            timerModel.incrementCurrentRound()
            needToIncrementRound = false
        }
    }

    private func checkIfShouldContinue() {
        runNextRound = timerModel.currentRound <= timerModel.noOfRounds
    }

    private func handleTimerCompletion() {
        timerModel.switchTimerMode(isAfterLastRound: true)
        timeRemaining = timerModel.getRemainingTimeBasedOnMode().toInt()
        isActive = false
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

    func resetRemainingTime() {
        if timerModel.precountdownTime.toInt() > 0 {
            timeRemaining = timerModel.precountdownTime.toInt()
        } else {
            timeRemaining = timerModel.getRemainingTimeBasedOnMode().toInt()
        }
    }
}

#Preview {
    TimerView()
}
