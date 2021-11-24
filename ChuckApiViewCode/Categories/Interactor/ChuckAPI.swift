
import Foundation

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

}
