//
//  MainView.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            VStack {
                TasksView()
                Spacer()
                Rectangle()
                    .frame(height: 0)
                    .background(.thinMaterial)
            }
            .background(Color.background)
            .tabItem {
                Label("Home", systemImage: "house")
            }

            VStack {
                FindView()
                Spacer()
                Rectangle()
                    .frame(height: 0)
                    .background(.thinMaterial)
            }
            .background(Color.background)
            .tabItem {
                Label("Find", systemImage: "magnifyingglass")
            }

            VStack {
                ProfileView()
                Spacer()
                Rectangle()
                    .frame(height: 0)
                    .background(.thinMaterial)
            }
            .background(Color.background)
            .tabItem {
                Label("Profile", systemImage: "person")
            }

        }
        .accentColor(.main)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
