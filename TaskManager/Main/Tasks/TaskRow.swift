//
//  TaskRow.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

struct TaskRow: View {
    @State private var showTask = false
    @Binding var task: Task
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "list.clipboard")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .background(LinearGradient.mainGradient)
                    .cornerRadius(10)
                    .padding(10)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(task.name)
                        .font(.headline)

                    Text(task.initiator)
                        .font(.subheadline)
                }
                
                Spacer()
            }
        }
        .onTapGesture {
            showTask = true
        }
        .navigationDestination(isPresented: $showTask) {
            TaskView(task: $task)
        }
//        .background(
//            NavigationLink (
//                destination: TaskView(), isActive: $isActive,
//                label: {
//                    EmptyView()
//                }
//            ))
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .constant(Task(coordinators: ["Artyom", "Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Artyom", name: "Test 1", next: 1, status: 0, date: Date())))
    }
}
