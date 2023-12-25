//
//  LogInView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI
import Combine

struct LogInView: View {
    @ObservedObject var viewModel = LogInViewModel()
    @State private var showingAlert = false
    @EnvironmentObject private var appRootManager: AppRootManager

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack {
                LogoView()

                TextField("Username", text: $viewModel.username)
                    .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom, 10)

//                TextField("Email", text: $viewModel.email)
//                    .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(6)
//                    .padding(.bottom, 10)
//                    .keyboardType(.emailAddress)
//                    .onReceive(Just(viewModel.email)) { newValue in
//                        let validString = newValue.filter { "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ._-+$!~&=#[]@".contains($0) }
//                        if validString != newValue {
//                            viewModel.email = validString
//                        }
//                    }

                SecureField("Password", text: $viewModel.password)
                    .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom, 20)

                Button(action: {
                    viewModel.tryLogin()
                }) {
                    Text("Log In")
                        .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient.mainGradient)
                        .cornerRadius(6)
                }
                .onChange(of: viewModel.result) { result in
                    switch result {
                    case .success:
                        appRootManager.currentRoot = .main
                    case .failure:
                        showingAlert.toggle()
                    case .none:
                        fatalError()
                    }
                }
                .alert(isPresented: $showingAlert) {
                    switch viewModel.result {
                    case .failure(let error):
                        return Alert(
                            title: Text("Error"),
                            message: Text(error.errorMessage),
                            dismissButton: .default(Text("Ok"))
                        )
                    default:
                        return Alert(title: Text(""))
                    }
                }

                Button(action: {
                    // Reset password
                }) {
                    Text("Forgot Password?")
                        .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                        .foregroundColor(.primary)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle("Log In")
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
