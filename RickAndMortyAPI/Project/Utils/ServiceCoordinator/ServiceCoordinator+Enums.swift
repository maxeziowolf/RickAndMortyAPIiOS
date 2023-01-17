//
//  ServiceCoordinatorEnums.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

enum ServiceStatus<T> {
    case success(data: T)
    case failed(error: ServiceErrorMessage)
    case unowned(error: String)
}

enum ServiceErrorMessage: String{
    case urlInvalid = "La url ingresada no es valida."
    case clientError = "Error por parte del cliente."
    case serverError = "Error por parte del servidor."
    case emptyRequest = "Respuesta vacia."
    case codingError = "Error de parse en los datos."
}

enum HTTPType: String{
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}
