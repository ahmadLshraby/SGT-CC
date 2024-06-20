//
//  AppDIContainer.swift
//  SGT-CC
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Infrastructure
import Application
import Core

public final class AppDIContainer: ObservableObject {
    private static var privateShared: AppDIContainer?
    
    public class func shared() -> AppDIContainer {
        guard let uwShared = privateShared else {
            print("AppDIContainer ✅")
            privateShared = AppDIContainer()
            return privateShared!
        }
        return uwShared
    }
    
    public class func destroy() {
        print("AppDIContainer ❌")
        privateShared = nil
    }
    
    deinit {
        print("AppDIContainer ❌")
        print("deinit AppDIContainer singleton")
    }
    
    // MARK: - View Models
    public func makePopularMoviesViewModel() -> PopularMoviesViewModel {
        return PopularMoviesViewModel(useCase: makePopularMoviesUseCase())
    }
    
    // MARK: - Use Cases
    public func makePopularMoviesUseCase() -> PopularMoviesUseCase {
        return PopularMoviesUseCaseImp(repository: makePopularMoviesRepository())
    }
    
    // MARK: - Repositories
    public func makePopularMoviesRepository() -> PopularMoviesRepository {
        return DefaultPopularMovies(apiClient: APIClient())
    }
}
