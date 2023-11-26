//
//  Color.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

extension LinearGradient {
    static var mainGradient: LinearGradient {
        let stops = [
            Gradient.Stop(color: Color(red: 0.61, green: 0.17, blue: 0.95), location: 0.00),
            Gradient.Stop(color: Color(red: 0.23, green: 0.28, blue: 0.98), location: 1.00)
        ]

        let startPoint = UnitPoint(x: 0.5, y: -0.17)
        let endPoint = UnitPoint(x: 0.61, y: 1.12)

        return LinearGradient(stops: stops, startPoint: startPoint, endPoint: endPoint)
    }
}
