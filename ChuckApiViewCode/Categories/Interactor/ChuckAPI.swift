
import Foundation

// criando uma tratativa para o tipo de erro
enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
}

class ChuckAPI: JokeCategoriesServiceProtocol {
    
    private let baseURLCategories = "https://api.chucknorris.io/jokes/categories"
    private let urlSession = URLSession.shared
    
    func fetchCategories(success: @escaping ([String]) -> Void, failure: @escaping (Error) -> Void) {

        guard let url = URL(string: baseURLCategories) else {
            print("erro URL")
            return
        }

        urlSession.dataTask(with: url) {(data, response, error) in

            guard let data = data else {
                return print("erro data (Dados)")
            }

            do {
                let categoryResponse = try JSONDecoder().decode([String].self, from: data)
                DispatchQueue.main.async {
                    success(categoryResponse)
                }
            } catch {
                return print("Erro response")
            }
        }.resume()
    }
    

//    static private let baseURL = "https://api.chucknorris.io/jokes/"
//
//
//
//    static func getAPI<T: Codable>(urlSent: String, expecting: T.Type, callback: @escaping (Result<T, ServiceError>) -> Void) {
//
//        let url = baseURL + urlSent
//
//        guard let url = URL(string: url) else {
//            callback(.failure(.invalidURL))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                callback(.failure(.network(error)))
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(expecting, from: data)
//                callback(.success(response))
//            } catch {
//                callback(.failure(.decodeFail(error)))
//            }
//
//        }
//
//        task.resume()
//    }
    
}
