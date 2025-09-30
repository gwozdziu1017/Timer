import SwiftUI

class TimerViewModel: ObservableObject {
    @Published public var isActive = true
    @Published public var isPaused: Bool = false
    @Published public var isPresented: Bool = false
    @Published public var timeRemaining = 100

    private var isStartButtonDisabled: Bool = false
    private var isPauseButtonDisabled: Bool = true
    private var isStopButtonDisabled: Bool = true

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
            }.disabled(isPauseButtonDisabled)

            Button("Stop") {
                self.timeRemaining = 100
                self.isActive = false
                self.setStartPauseStopButtonsDisabled(
                    startButtonDisabled: false,
                    pauseButtonDisabled: true,
                    stopButtonDisabled: true)
            }.disabled(isStopButtonDisabled)
        }
    }

    func getSettingsButtonView() -> some View {
        Button("Settings") {
            self.isPresented.toggle()
        }
        .background(Color.green)
    }

    func onChange(scenePhase: ScenePhase) {
        if scenePhase == .active {
            self.isActive = true
        } else {
            self.isActive = false
        }
    }

    func onReceivingTimer(timer: Date) {
        guard self.isActive else { return }

        if self.timeRemaining > 0 {
            self.timeRemaining -= 1
        }
    }

    func getTimeView() -> some View {
        Text("Time: \(self.timeRemaining)")
            .font(.system(size: 60, design: .monospaced))
            .foregroundStyle(.green)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }

}
