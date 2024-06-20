//
//  SGT_CCApp.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/19/24.
//

import SwiftUI

@main
struct SGT_CCApp: App {
    let container = AppDIContainer.shared()
    
    var body: some Scene {
        WindowGroup {
            PopularMoviesView(viewModel: container.makePopularMoviesViewModel())
                .environment(\.appDIContainer, container)
        }
    }
}
