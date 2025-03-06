//
//  DetalleProductoView.swift
//  APP_GameShop_IOSPrueba
//
//  Created by Usuario invitado on 25/2/25.
//

import SwiftUICore
import SwiftUI
struct DetalleProductoView: View {
    var producto: Producto
    @StateObject private var gestDatos = GestorDatos()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Image(producto.imagen)
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(10)

            Text(producto.nombre)
                .font(.title)
                .bold()

            Text(producto.descripcion)
                .font(.body)
                .padding()

            Text("Precio: $\(producto.precio, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.green)

            Button("Añadir al carrito") {
                gestDatos.agregarProductoAlCarrito(producto: producto)
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

