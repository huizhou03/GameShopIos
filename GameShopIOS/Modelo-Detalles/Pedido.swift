//
//  Pedidos.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 13/3/25.
//
import SwiftUI
struct Pedido: Codable {
    let correoUsuario: String
    let producto: Producto
    let cantidad: Int
    let fecha: String
}
