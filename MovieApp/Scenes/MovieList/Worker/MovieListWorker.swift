//
//  MovieListWorker.swift
//  MovieApp
//
//  Created by FEKRANE on 25/12/2023.
//

import Foundation
import RxSwift

protocol MovieListWorkerProtocol {
    func getMovieList(request: MovieListRequest, completion: @escaping (Result<MovieListResponse, NetworkError>) -> Void) -> Void
}

final class MovieListWorker {
   
    private let httpClient: any HttpClient
    private let tokenProvider: any TokenProvider
    private let disposeBag = DisposeBag()

    init(httpClient: some HttpClient = NetworkManager.sharedInstance, tokenProvider: some TokenProvider = RefreshTokenService()) {
        self.httpClient = httpClient
        self.tokenProvider = tokenProvider
    }
    
    private func retrieveMovies(request: MovieListRequest, endpoint: String) -> Single<MovieListResponse> {
         tokenProvider
            .tokenObservable()
            .map { [ "Authorization": "Bearer \($0)"] }
            .flatMap { [httpClient] headers -> Single<MovieListResponse> in
               return httpClient.request(
                    APIConfiguration.upcommingMovies.endpoint,
                    queryParams: request.asDictionary(),
                    headers: headers
                ).map(GenericObjectMapper.map)
            }.asSingle()
    }
}

extension MovieListWorker: MovieListWorkerProtocol {
    func getMovieList(request: MovieListRequest, completion: @escaping (Result<MovieListResponse, NetworkError>) -> Void) {
        let endpoint = switch request.movieCategory {
        case .popular:
            APIConfiguration.popularMovies.endpoint
        case .topRatedMovies:
            APIConfiguration.topRatedMovies.endpoint
        case .upcoming:
            APIConfiguration.upcommingMovies.endpoint
        }
        retrieveMovies(request: request, endpoint: endpoint)
            .subscribe(
                onSuccess: { movieList in
                    completion(.success(movieList))
                },
                onFailure: { error in
                    if let networkError = error as? NetworkError {
                        completion(.failure(networkError))
                    } else {
                        completion(.failure(NetworkError.unexpected))
                    }
                })
            .disposed(by: disposeBag)
    }
}
