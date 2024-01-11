//
//  TasksView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var viewModel = TasksViewModel()
    @State private var selectedTab = 0
    @State private var showAddTask = false
    @ObservedObject var apimanager = APIManager.shared

    var body: some View {
        NavigationStack {
            Color.background.ignoresSafeArea(.all).overlay {

                VStack {

                    HStack {
                        Spacer()

                        Button(action: {
                            showAddTask.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)

                                Text("Add")
                                    .font(.system(size: 10, weight: Font.Weight.medium, design: .default))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(LinearGradient.mainGradient)
                            .cornerRadius(15)
                        }
                        .navigationDestination(isPresented: $showAddTask) {
                            AddTaskView(showAddTask: $showAddTask)
                        }
                        .padding([.top, .trailing], 16)
                    }

                    Picker("", selection: $selectedTab) {
                        Text("In-progress").tag(1)
                        Text("Approved").tag(3)
                        Text("Declined").tag(4)
                    }
                    .pickerStyle(.segmented)
                    .padding(12)
                    .onChange(of: selectedTab) { newValue in
                        viewModel.updateTasksToShow(for: newValue)
                    }
                    .onAppear {
                        viewModel.updateTasksToShow(for: selectedTab)
                    }

                    ForEach(viewModel.tasksToShow, id: \.id) { task in
                        TaskRow(task: $apimanager.allTasks.first(where: {$0.wrappedValue.id == task.id})!)
                            .background(.white)
                            .cornerRadius(10)
                            .contextMenu {

                                switch task.status {
                                case 1:
                                    Button(action: {
                                        changeStatusOfTask(id: task.id, newStatus: 3)
                                    }) {
                                        Text("Approve")
                                        Image(systemName: "checkmark")
                                    }

                                    Button(action: {
                                        changeStatusOfTask(id: task.id, newStatus: 4)
                                    }) {
                                        Text("Decline")
                                        Image(systemName: "xmark")
                                    }

                                case 3:

                                    Button(action: {
                                        changeStatusOfTask(id: task.id, newStatus: 4)
                                    }) {
                                        Text("Decline")
                                        Image(systemName: "xmark")
                                    }

                                case 4:

                                    Button(action: {
                                        changeStatusOfTask(id: task.id, newStatus: 3)
                                    }) {
                                        Text("Approve")
                                        Image(systemName: "checkmark")
                                    }

                                default:
                                    Button(action: { }) { }
                                }

                                Button(action: {
                                    removeTask(id: task.id)
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                    }
                    .padding([.leading, .trailing], 20)

                    Spacer()
                }
            }
        }
        .accentColor(.white)
    }

    private func changeStatusOfTask(id: String, newStatus: Int) {
        viewModel.changeStatus(id: id, newStatus: newStatus)
        viewModel.updateTasksToShow(for: selectedTab)
    }

    private func removeTask(id: String) {
        viewModel.removeTask(id: id)
        viewModel.updateTasksToShow(for: selectedTab)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
