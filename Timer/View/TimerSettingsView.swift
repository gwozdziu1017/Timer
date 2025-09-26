//
//  TimerSettingsView.swift
//  Timer
//
//  Created by Damian Gwóźdź on 24/09/2025.
//

import SwiftUI

struct TimerSettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
            //Spacer()
            VStack { // all properties
                VStack { // no of rounds
                    Text("Number of rounds:")
                    Picker("noofrounds", selection: .constant(1)) {
                        ForEach(1..<51){elem  in
                            Text("\(elem)")
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                VStack { // length
                    Text("Work time:")
                    HStack {
                        Text("Minutes:")
                        Picker("min", selection: .constant(0)) {
                            ForEach(1..<61){elem  in
                                Text("\(elem)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                        Text("Seconds:")
                        Picker("sec", selection: .constant(0)) {
                            ForEach(1..<61){elem  in
                                Text("\(elem)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                    
                }
                VStack {
                    Text("Break time:")
                    Picker("breaktime", selection: .constant(0)) {
                        // make it like 5 10 30 60 sec
                        ForEach(1..<6){ elem  in
                            Text("\(elem)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                VStack {// precount
                    Text("Precount:")
                    Picker("precount", selection: .constant(0)) {
                        // get from enum
                        ForEach(1..<6){ elem  in
                            Text("\(elem)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                HStack {
                    Button("Save") {
                        // save
                    }
                    // button save
                }
            }
        }
    }
}

#Preview {
    TimerSettingsView()
}
