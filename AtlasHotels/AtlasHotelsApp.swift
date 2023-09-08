//
//  IOSProject_MVVMApp.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 08/08/23.
//

import SwiftUI

@main
struct AtlasHotelsApp: App {
        var body: some Scene {
            WindowGroup {
                SplashView()
            }
        }
}

struct AtlasHotelsApp_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
