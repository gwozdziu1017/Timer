import SwiftUI

struct ControlButton: View { // start/pause/stop
    let tittle: String
    let isDisabled: Bool
    let action: () -> Void

    let activeButtonColor: Color = .mint.opacity(0.5)
    let disabledButtonColor: Color = .gray.opacity(0.7)

    var body: some View {
        Button(action: action) {
            Text(tittle)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(isDisabled ? .gray : .white)
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .background(
                    Capsule()
                        .fill(isDisabled ? disabledButtonColor : activeButtonColor)
                )
        }
        .disabled(isDisabled)
    }
}

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

    private var modeColor: Color {
        switch self.timerModel.timerMode {
        case .Work:
            return .red
        case .Break:
            return .green
        case .Finished:
            return .gray
        case .Precountdown:
            return .orange
        }
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
        return HStack(spacing: 10) {
            ControlButton(tittle: "Start", isDisabled: self.isStartButtonDisabled) {
                self.isActive = true
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: true,
                    pauseButtonDisabled: false,
                    stopButtonDisabled: false)
            }
            ControlButton(tittle: "Pause", isDisabled: self.isPauseButtonDisabled) {
                self.isActive = false
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: false)
            }
            ControlButton(tittle: "Stop", isDisabled: self.isStopButtonDisabled) {
                self.resetTimer()
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: true)
            }
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
        ControlButton(tittle: "Settings", isDisabled: false) {
            self.isPresented.toggle()
        }
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

    var backgroundColor: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(0.8)
    }

    func getTimeView() -> some View {
        ZStack {
            Circle()
                .stroke(modeColor.opacity(0.2), lineWidth: 20)
            Circle()
                .stroke(modeColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            
            VStack(spacing: 5) {
                Text("\(self.timeRemaining.toTime().printable())")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundStyle(self.modeColor)
                    .monospacedDigit()
            }
        }
        .frame(width: 280, height: 280)
        .padding()
    }

    func getTimerModeView() -> some View {
        Text(timerModel.timerMode.getModeString())
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .foregroundStyle(modeColor)
            .padding(.vertical, 10)
            .padding(.horizontal, 100)
            .background(
                Capsule()
                    .fill(modeColor.opacity(0.2))
            )
    }
    
    func getCurrentRoundView() -> some View {
        Text("Round: \(self.timerModel.currentRound) of \(self.timerModel.noOfRounds)")
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .foregroundStyle(.white)
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
