//
//  ItemCarrito.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 11/3/25.
//

import SwiftUI
struct ItemCarrito: Codable {
    let producto: Producto
    var cantidad: Int
    let correoUsuario: String
}
