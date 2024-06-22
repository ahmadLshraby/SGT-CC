//
//  PopularMoviesViewModelTests.swift
//  ApplicationTests
//
//  Created by AhmadShraby on 6/19/24.
//

import XCTest
import Core
import Combine
@testable import Application

class PopularMoviesViewModelTests: XCTestCase {
    
    var viewModel: PopularMoviesViewModel!
    var useCase: MockPopularMoviesUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        useCase = MockPopularMoviesUseCase() // to return the data directly and not proceed to Repository in Infrastructure
        viewModel = PopularMoviesViewModel(useCase: useCase)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        useCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.movies.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.canLoadMore)
    }
    
    func testFetchPopularMoviesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch popular movies")
        
        useCase.result = .success(MoviesResponse(results: [MoviesResult(id: 1, title: "Test Movie")], totalPages: 1))
        
        viewModel.fetchPopularMovies()
        
        viewModel.$movies
            .dropFirst()
            .sink { movies in
                XCTAssertFalse(movies.isEmpty)
                XCTAssertEqual(movies.first?.title, "Test Movie")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchPopularMoviesFailure() {
        let expectation = XCTestExpectation(description: "Fetch popular movies failure")
        
        useCase.result = .failure(NetworkServicesError.responseError(response: "Failed to fetch"))
        
        viewModel.fetchPopularMovies()
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                XCTAssertTrue(errorMessage?.isEmpty == false)
//                XCTAssertEqual(errorMessage, "Failed to fetch")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingStateWhileFetching() {
        let expectation = XCTestExpectation(description: "Loading state while fetching")
        
        useCase.result = .success(MoviesResponse(results: [], totalPages: 1))
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                XCTAssertTrue(isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchPopularMovies()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchNextPageSuccess() {
        let expectation = XCTestExpectation(description: "Fetch next page success")
        
        useCase.result = .success(MoviesResponse(results: [MoviesResult(id: 2, title: "Next Page Movie")], totalPages: 2))
        
        viewModel.fetchNextPage()
        
        viewModel.$movies
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.last?.title, "Next Page Movie")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchNextPageFailure() {
        let expectation = XCTestExpectation(description: "Fetch next page failure")
        
        useCase.result = .failure(NetworkServicesError.responseError(response: "Failed to fetch"))
        
        viewModel.fetchNextPage()
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                XCTAssertTrue(errorMessage?.isEmpty == false)
//                XCTAssertEqual(errorMessage, "Failed to fetch")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingStateWhileFetchingNextPage() {
        let expectation = XCTestExpectation(description: "Loading state while fetching next page")
        
        useCase.result = .success(MoviesResponse(results: [], totalPages: 2))
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                XCTAssertTrue(isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchNextPage()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCanLoadMore() {
        XCTAssertFalse(viewModel.canLoadMore)
        
        useCase.result = .success(MoviesResponse(results: [], totalPages: 1))
        viewModel.fetchPopularMovies()

        XCTAssertFalse(viewModel.canLoadMore)
        
        useCase.result = .success(MoviesResponse(results: [MoviesResult(id: 3, title: "Movie 2"),
                                                           MoviesResult(id: 4, title: "Movie 3")], totalPages: 10))
        viewModel.fetchPopularMovies()

        XCTAssertTrue(viewModel.canLoadMore)
    }
    
    // Performance Tests
    func testPerformanceFetchPopularMovies() {
        useCase.result = .success(MoviesResponse(results: [MoviesResult(id: 1, title: "Test Movie")], totalPages: 1))
        
        measure {
            viewModel.fetchPopularMovies()
        }
    }

    func testPerformanceFetchNextPage() {
        useCase.result = .success(MoviesResponse(results: [MoviesResult(id: 2, title: "Next Page Movie")], totalPages: 2))
        
        measure {
            viewModel.fetchNextPage()
        }
    }
}

class MockPopularMoviesUseCase: PopularMoviesUseCase {
    var result: Result<MoviesResponse, NetworkServicesError>!
    
    func getPopularMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkServicesError> {
        return Future<MoviesResponse, NetworkServicesError> { promise in
            promise(self.result)
        }.eraseToAnyPublisher()
    }
}
