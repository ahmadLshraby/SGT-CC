//
//  AppDIContainerEnvironmentKey.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/19/24.
//

import SwiftUI

struct AppDIContainerEnvironmentKey: EnvironmentKey {
    static var defaultValue: AppDIContainer = AppDIContainer.shared()
}

extension EnvironmentValues {
    var appDIContainer: AppDIContainer {
        get { self[AppDIContainerEnvironmentKey.self] }
        set { self[AppDIContainerEnvironmentKey.self] = newValue }
    }
}
