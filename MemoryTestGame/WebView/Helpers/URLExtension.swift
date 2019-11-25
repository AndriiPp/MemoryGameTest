//
//  URLExtension.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/24/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

extension URL {
    //MARK: - Method for get param by key of URL
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
