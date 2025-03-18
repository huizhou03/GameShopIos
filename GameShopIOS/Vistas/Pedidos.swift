//
//  Pedidos.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 13/3/25.
//

import SwiftUI

struct PedidosView: View {
    @ObservedObject var gestDatos: GestorDatos
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(gestDatos.pedidos.indices, id: \.self) { index in
                    HStack {
                        Image(gestDatos.pedidos[index].producto.imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)

                        VStack(alignment: .leading) {
                            Text(gestDatos.pedidos[index].producto.nombre)
                                .font(.headline)
                            Text("$\(gestDatos.pedidos[index].producto.precio, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.green)
                            Text("Cantidad: \(gestDatos.pedidos[index].cantidad)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Text("Fecha: \(gestDatos.pedidos[index].fecha)")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Pedidos")
            .onAppear {
                gestDatos.cargarJSONPedidos(correoUsuario: gestDatos.email)
            }
        }
    }
}

#Preview {
    PedidosView(gestDatos: GestorDatos())
}

