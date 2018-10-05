//
//  ModelDecoder.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol DecoderInterface {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: DecoderInterface {}

struct ModelDecoder<T: Decodable> {
    
    private let decoder: DecoderInterface
    
    init(decoder: DecoderInterface = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func model(from data: Data) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}
