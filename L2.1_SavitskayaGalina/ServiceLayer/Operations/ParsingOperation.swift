//
//  ParsingOperation.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 29.01.2023.
//

import Foundation

class ParsingOperation<Model: Decodable>: Operation {
    var outputModel: Model?
    
    override func main() {
        guard let loaderOperation = dependencies .first(where: { $0 is FetchDataOperation }) as? FetchDataOperation,
              let data = loaderOperation.outputData
        else { return }
        
        outputModel = try? JSONDecoder().decode(Model.self, from: data)
    }
}
