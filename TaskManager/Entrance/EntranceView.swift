//
//  ContentView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

struct EntranceView: View {
    @State private var showLogInView = false
    @State private var showRegistrationView = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                VStack {
                    LogoView()

                    Button(action: {
                        showLogInView.toggle()
                    }) {
                        Text("Log In")
                            .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient.mainGradient)
                            .cornerRadius(6)
                    }
                    Button(action: {
                        showRegistrationView.toggle()
                    }) {
                        Text("Register")
                            .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient.mainGradient)
                            .cornerRadius(6)
                    }
                }
                .padding()
                .navigationDestination(isPresented: $showLogInView) {
                    LogInView()
                }
                .navigationDestination(isPresented: $showRegistrationView) {
                    RegistrationView()
                }
            }
        }
        .accentColor(.black)
    }
}

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView()
    }
}
