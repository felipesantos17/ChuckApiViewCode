
import Foundation

// criando uma tratativa para o tipo de erro
enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
}

protocol ChuckAPIGenericProtocol {
    func getAPI<T: Codable>(urlSent: String, expecting: T.Type, callback: @escaping (Result<T, ServiceError>) -> Void)
}

class ChuckAPIGeneric: ChuckAPIGenericProtocol {
    
    private let baseURL = "https://api.chucknorris.io/jokes/"

    func getAPI<T: Codable>(urlSent: String, expecting: T.Type, callback: @escaping (Result<T, ServiceError>) -> Void) {

        let url = self.baseURL + urlSent

        guard let url = URL(string: url) else {
            callback(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.network(error)))
                return
            }

            do {
                let response = try JSONDecoder().decode(expecting, from: data)
                callback(.success(response))
            } catch {
                callback(.failure(.decodeFail(error)))
            }

        }

        task.resume()
    }
}
