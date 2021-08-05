//
//  Webservice.swift
//  HotCoffee
//
//  Created by Mingeun Yang on 2021/07/29.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

//제너릭으로 코드를 짜면서 어떤 데이터든 다룰 수 있게 되었다.
struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            //데이터가 들어왔고 에러가 닐이 아닐 때, 에러가 났을 때 completion 호출 하고 종료
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            // 빈 배열이 들어왔다. try?를 try!로 바꿔서 왜 데이터가 안 들어오는지 확인하자
            let result = try? JSONDecoder().decode(T.self, from: data)

            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume() //resume()을 잊지말자!
        
    }
    
}
