//
//  FindView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI
import Combine

struct FindView: View {
    @ObservedObject var viewModel = FindViewModel()
    @State private var searchQuery = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchQuery)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.white)
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .onAppear {
                    viewModel.filter(search: searchQuery)
                }
            
            ForEach(viewModel.filteredTasks, id: \.id) { task in
                TaskRow(task: $viewModel.filteredTasks.first(where: {$0.wrappedValue.id == task.id})!)
                    .background(.white)
                    .cornerRadius(10)
                    .contextMenu {
                        
                        switch task.status {
                        case 0:
                            Button(action: {
                                changeStatusOfTask(id: task.id, newStatus: 1)
                            }) {
                                Text("Approve")
                                Image(systemName: "checkmark")
                            }
                            
                            Button(action: {
                                changeStatusOfTask(id: task.id, newStatus: 2)
                            }) {
                                Text("Decline")
                                Image(systemName: "xmark")
                            }
                            
                        case 1:
                            Button(action: {
                                changeStatusOfTask(id: task.id, newStatus: 0)
                            }) {
                                Text("To in-progress")
                                Image(systemName: "clock")
                            }
                            
                            Button(action: {
                                changeStatusOfTask(id: task.id, newStatus: 2)
                            }) {
                                Text("Decline")
                                Image(systemName: "xmark")
                            }
                            
                        case 2:
                            Button(action: {
                                changeStatusOfTask(id: task.id, newStatus: 0)
                            }) {
                                Text("To in-progress")
                                Image(systemName: "clock")
                            }
                            
                            Button(action: {
                                changeStatusOfTask(id: task.id, newStatus: 1)
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
        .onChange(of: searchQuery) { query in
            viewModel.filter(search: query)
        }
    }
    
    private func changeStatusOfTask(id: String, newStatus: Int) {
        viewModel.changeStatus(id: id, newStatus: newStatus)
    }
    
    private func removeTask(id: String) {
        viewModel.removeTask(id: id)
    }
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
