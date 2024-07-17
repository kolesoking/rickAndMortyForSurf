import Foundation

enum NetworkError: Error {
    case InvalidURL
    case JSONDecodingError
    case RequestError(String)
    case NoData
    case UnknownError
}

final class NetworkServiceImpl: NetworkService {
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    func request(with endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            return completion(.failure(NetworkError.InvalidURL))
        }

        let task = session.dataTask(with: configureRequest(with: url)) { data, response, error in
            if let error {
                return completion(.failure(NetworkError.RequestError(error.localizedDescription)))
            }
            
            guard let data else {
                return completion(.failure(NetworkError.NoData))
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    func decodeJSONData<T: Codable>(data: Data) throws -> T {
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.JSONDecodingError
        }
    }
}

// MARK: - Private Extension -
private extension NetworkServiceImpl {
    func configureRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
