//
//  MovieDetailsViewModelTests.swift
//  Application
//
//  Created by AhmadShraby on 6/22/24.
//

import XCTest
import Core
import Combine
@testable import Application

final class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModel!
    var useCase: MockMovieDetailsUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        useCase = MockMovieDetailsUseCase()
        viewModel = MovieDetailsViewModel(useCase: useCase, movieID: 1)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        useCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertNil(viewModel.movieDetails)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchMovieDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch movie details")
        
        useCase.result = .success(MovieDetailsResponse(id: 1, overview: "Test Overview", title: "Test Movie"))
        
        viewModel.getMovieDetails()
        
        viewModel.$movieDetails
            .dropFirst()
            .sink { details in
                XCTAssertNotNil(details)
                XCTAssertEqual(details?.title, "Test Movie")
                XCTAssertEqual(details?.overview, "Test Overview")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMovieDetailsFailure() {
        let expectation = XCTestExpectation(description: "Fetch movie details failure")
        
        useCase.result = .failure(NetworkServicesError.responseError(response: "Failed to fetch"))
        
        viewModel.getMovieDetails()
        
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
        
        useCase.result = .success(MovieDetailsResponse(id: 1, overview: "Test Overview", title: "Test Movie"))
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                XCTAssertTrue(isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getMovieDetails()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Performance Tests
    func testPerformanceFetchMovieDetails() {
        useCase.result = .success(MovieDetailsResponse(id: 1, overview: "Test Overview", title: "Test Movie"))
        
        measure {
            viewModel.getMovieDetails()
        }
    }
}

class MockMovieDetailsUseCase: MovieDetailsUseCase {
    var result: Result<MovieDetailsResponse, NetworkServicesError>!
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, NetworkServicesError> {
        return Future<MovieDetailsResponse, NetworkServicesError> { promise in
            promise(self.result)
        }.eraseToAnyPublisher()
    }
}
