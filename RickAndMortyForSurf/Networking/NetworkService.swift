import Foundation

protocol NetworkService {
    func request(with method: String, completion: @escaping (Result<Data, Error>) -> Void)
    func decodeJSONData<T: Codable>(data: Data) throws -> T
}
