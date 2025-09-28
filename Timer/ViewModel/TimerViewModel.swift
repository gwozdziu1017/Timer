import SwiftUI

class TimerViewModel: ObservableObject {
    @Published public var isActive = true
    @Published public var isPaused: Bool = false
    @Published public var isPresented: Bool = false
    @Published public var timeRemaining = 100

    func shouldStopBeDisabled() -> Bool {
        return !self.isActive && !self.isPaused// && self.isStartPressed
    }

    func getStartPauseStopButtonsView() -> some View {
        HStack {
            Button("Start") {
                self.isActive = true
                self.isPaused = false
                //self.isStartPressed = true
            }.disabled(self.isActive)
            Button("Pause") {
                self.isActive = false
                self.isPaused = true
            }.disabled(!self.isActive)
            Button("Stop") {
                self.timeRemaining = 100
                self.isActive = false
            }.disabled(!self.isActive && !self.isPaused)
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
