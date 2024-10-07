//
//  URL+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation

extension URL {

    /// Build a new URL with the given query items
    /// This method might invalidate some URLQueryItem if the name/values aren't able to be encoded to urlQueryAllowed
    /// - Parameter items: URLQueryItem
    /// - Returns: New url with the query items
    func withQueryItems(_ items: [URLQueryItem]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)

        urlComponents?.percentEncodedQuery = items
            .compactMap { item -> String? in
                guard
                    let name = item.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowedWithoutPlus),
                    let value = item.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowedWithoutPlus)
                else {
                    return nil
                }

                return "\(name)=\(value)"
            }
            .joined(separator: "&")

        return urlComponents?.url ?? self
    }

    var lastPathComponentWithoutExtension: String {
        lastPathComponent.replacingOccurrences(of: ".\(pathExtension)", with: "")
    }
}

private extension CharacterSet {
    static let urlQueryAllowedWithoutPlus: CharacterSet = {
        CharacterSet.urlQueryAllowed.subtracting(.init(charactersIn: "+"))
    }()
}
