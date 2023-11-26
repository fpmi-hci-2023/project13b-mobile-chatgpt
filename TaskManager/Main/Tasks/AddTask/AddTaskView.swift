//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 18.11.23.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel = AddTaskViewModel()
    @Binding var showAddTask: Bool
    @State var task: Task = Task()
    @State var tempCoordinator = ""
    @State var showsDatePicker = false
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()

    var body: some View {
        GeometryReader { geometry in
            let sizeOfSecondView = geometry.size.height / 1.5
            ZStack {
                Color.background.ignoresSafeArea(.all)

                VStack {
                    HStack {
                        Text("Name")
                            .font(.system(size: 22))
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding([.leading, .top], 16)

                    TextField("", text: $task.name)
                        .placeholder(when: task.name.isEmpty) {
                            Text("Name").foregroundColor(.white)
                        }
                        .underlined()
                        .foregroundColor(.white)
                        .padding([.leading, .trailing, .bottom], 16)

                    HStack {
                        Text("Date")
                            .font(.system(size: 22))
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.leading, 16)

                    HStack {
                        Text("\(dateFormatter.string(from: task.date))")
                            .padding([.bottom], 16)
                            .padding(.top, 1)
                            .foregroundColor(.white)
                            .onTapGesture {
                                self.showsDatePicker.toggle()
                            }

                        Spacer()
                    }
                    .underlined()
                    .padding([.leading, .trailing, .bottom], 16)

                    Spacer()

                }
                .background(
                    LinearGradient.mainGradient
                )

                VStack {
                    Spacer()

                    Rectangle()
                        .frame(height: sizeOfSecondView)
                        .foregroundColor(.white)
                        .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                    //                        .cornerRadius(30)
                        .overlay {
                            VStack {

                                HStack {
                                    Text("Coordinators")
                                        .font(.system(size: 22))
                                        .foregroundColor(.gray)

                                    ForEach(task.coordinators, id: \.self) { coordinator in
                                        Text(coordinator)
                                            .contextMenu {
                                                Button(action: {
                                                    let index = task.coordinators.firstIndex(where: {$0 == coordinator})!
                                                    task.coordinators.remove(at: index)
                                                }) {
                                                    Text("Remove")
                                                    Image(systemName: "trash")
                                                }
                                            }
                                    }

                                    Spacer()
                                }
                                .padding([.leading, .top], 16)

                                TextField("", text: $tempCoordinator, axis: .vertical)
                                    .placeholder(when: tempCoordinator.isEmpty) {
                                        Text("Coordinators").foregroundColor(.gray)
                                    }
                                    .underlined(color: .gray)
                                    .padding([.leading, .trailing, .bottom], 16)
                                    .onSubmit {
                                        task.coordinators.append(tempCoordinator)
                                        tempCoordinator = ""
                                    }

                                HStack {
                                    Text("Description")
                                        .font(.system(size: 22))
                                        .foregroundColor(.gray)

                                    Spacer()
                                }
                                .padding([.leading, .top], 16)

                                TextField("", text: $task.description, axis: .vertical)
                                    .placeholder(when: task.description.isEmpty) {
                                        Text("Description").foregroundColor(.gray)
                                    }
                                    .underlined(color: .gray)
                                    .padding([.leading, .trailing, .bottom], 16)

                                HStack {
                                    Text("State")
                                        .font(.system(size: 22))
                                        .foregroundColor(.gray)

                                    Spacer()
                                }
                                .padding([.leading, .top], 16)

                                Picker("", selection: $task.status) {
                                    Text("In-progress").tag(0)
                                    Text("Approved").tag(1)
                                    Text("Declined").tag(2)
                                }
                                .pickerStyle(.segmented)
                                .padding([.leading, .trailing, .bottom], 16)

                                Button(action: {
                                    viewModel.addTask(task: task)
                                    showAddTask.toggle()
                                }) {
                                    Text("Add")
                                        .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(LinearGradient.mainGradient)
                                        .cornerRadius(6)
                                }
                                .padding([.leading, .trailing], 16)

                                Spacer()
                            }
                        }
                }

            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showsDatePicker) {
                DatePickerView(selectedDate: $task.date, showDatePicker: $showsDatePicker)
                    .presentationDetents([.height(sizeOfSecondView)])
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(showAddTask: .constant(false))
    }
}
