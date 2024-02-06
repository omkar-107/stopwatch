import SwiftUI

struct ContentView: View {
    @State private var isRunning = false
    @State private var elapsedTime = 0.0
    @State private var laps: [Double] = []
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationView {
            VStack {
                Text(String(format: "%.2f", elapsedTime))
                    .font(.system(size: 50, weight: .thin, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 250, height: 120)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue))
                    .padding()

                HStack(spacing: 40) {
                    Button(action: {
                        isRunning.toggle()
                        if isRunning {
                            startStopwatch()
                        } else {
                            stopStopwatch()
                        }
                    }) {
                        Text(isRunning ? "Stop" : "Start")
                            .padding()
                            .foregroundColor(.white)
                            .background(isRunning ? Color.red : Color.green)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        addLap()
                    }) {
                        Text("Lap")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        resetStopwatch()
                    }) {
                        Text("Reset")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                .padding()

                
                    List {
                        ForEach(laps.reversed(), id: \.self) { lap in
                            Text("\(NSString(format: "%.2f", lap)) seconds"  )
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            
                            
                        }
                    }
                
                
            }
//            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Stopwatch", displayMode: .inline)
        }
    }

    private func startStopwatch() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.elapsedTime += 0.1
        }
    }

    private func stopStopwatch() {
        timer?.invalidate()
    }

    private func addLap() {
        laps.append(elapsedTime)
    }

    private func resetStopwatch() {
        elapsedTime = 0.0
        timer?.invalidate()
        timer = nil
        isRunning = false
        laps.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
