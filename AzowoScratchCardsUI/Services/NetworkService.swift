import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest
    case invalidURL
    case invalidResponse
    case apiError
    case unknown
    case taskAlreadyExists
    case noInternetConnection
}

protocol NetworkServiceProtocol: AnyObject {
    func request<T: Decodable>(url: String, method: HTTPMethod, body: [String: Any]?, headers: [String: String]?) -> AnyPublisher<(response: T, statusCode: Int), Error>
}

class NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(url: String, method: HTTPMethod, body: [String: Any]?, headers: [String: String]?) -> AnyPublisher<(response: T, statusCode: Int), Error> {
        
        guard let request = createURLRequest(url: url, method: method, body: body, headers: headers) else {
            return Fail(error: NetworkError.invalidRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> (response: T, statusCode: Int) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(T.self, from: data)
                
                return (decodedResponse, httpResponse.statusCode)
            }
            .mapError { error -> Error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func createURLRequest(url: String, method: HTTPMethod, body: [String: Any]?, headers: [String: String]?) -> URLRequest? {
        guard let requestURL = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonData
            } catch {
                return nil
            }
        }
        
        return request
    }
}
