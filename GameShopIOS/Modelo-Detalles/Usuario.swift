//
//  Usuario.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 13/3/25.
//

import Foundation
struct Usuario:Codable, Identifiable{
    let id: String
    var nombre: String
    let correo: String
    var dirPostal: String
    var newsletter: Bool
}

struct UsuariosResponse: Codable {
    var Usuarios: [Usuario]
}
