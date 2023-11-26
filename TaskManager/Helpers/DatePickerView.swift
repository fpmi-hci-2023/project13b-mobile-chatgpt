//
//  DatePickerView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 18.11.23.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)

                Spacer()

                Button(action: {
                    showDatePicker.toggle()
                }) {
                    Text("Done")
                        .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient.mainGradient)
                        .cornerRadius(6)
                }
            }
            .padding()
            .background(Color.background)
        }
    }
}
