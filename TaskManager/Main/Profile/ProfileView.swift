//
//  ProfileView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            Image(systemName: viewModel.photo)
                .resizable()
                .foregroundColor(.main)
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1.5))
                .padding(.top, 20)
            
            Text("Someone")
                .font(.system(size: 20, design: .default))
                .foregroundColor(.black)
                .padding(.top, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("About")
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    
                    TextField("", text: $viewModel.about, axis: .vertical)
                        .placeholder(when: viewModel.about.isEmpty) {
                            Text("About").foregroundColor(.black)
                        }
                        .underlined(color: .black)
                        .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Contact")
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Text("Phone: ")
                            .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                        
                        TextField("", text: $viewModel.phone)
                            .placeholder(when: viewModel.phone.isEmpty) {
                                Text("Phone").foregroundColor(.black)
                            }
                            .underlined(color: .black)
                            .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                    }
                    
                    HStack{
                        Text("Email: ")
                            .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                        TextField("", text: $viewModel.email)
                            .placeholder(when: viewModel.email.isEmpty) {
                                Text("Email").foregroundColor(.black)
                            }
                            .underlined(color: .black)
                            .font(.system(size: 17, weight: Font.Weight.medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                    }
                    
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
