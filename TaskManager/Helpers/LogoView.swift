//
//  LogoView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image(systemName: "list.clipboard")
            .resizable()
            .scaledToFit()
            .padding(10)
            .frame(width: 100, height: 100)
            .imageScale(.large)
            .foregroundColor(.white)
            .background(LinearGradient.mainGradient)
            .cornerRadius(20)
        Text("Task Manager")
            .font(.system(size: 25, weight: Font.Weight.medium, design: .default))
            .padding(.bottom, 60)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
