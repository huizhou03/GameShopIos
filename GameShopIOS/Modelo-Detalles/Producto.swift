//
//  Producto.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 20/2/25.
//
import Foundation
struct Producto:Codable, Identifiable{
    let id: String
    let nombre: String
    var precio: Double
    let descripcion: String
    let imagen: String
    var stock: Int
}
