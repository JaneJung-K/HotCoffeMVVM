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

//제너릭으로 코드를 짜면서 어떤 데이터든 다룰 수 있게 되었다.
struct Resource<T: Codable> {
    let url: URL
}

class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            //데이터가 들어왔고 에러가 닐이 아닐 때, 에러가 났을 때 completion 호출 하고 종료
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
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
