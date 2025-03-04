//
//  Tienda.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 4/3/25.
//
//Tienda
import SwiftUI
struct TiendaView: View {
    @StateObject private var gestDatos = GestorDatos()
    @State private var productoSeleccionado: Producto? = nil
    @State private var mostrarSheet = false
    var body: some View{
        NavigationView {
            List(gestDatos.productosTienda) { producto in
                            HStack {
                                Image(producto.imagen) // Asegúrate de tener las imágenes en tu proyecto
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(producto.nombre)
                                        .font(.headline)
                                    Text("$\(producto.precio, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                }
                            }
                            .padding()
                            .onTapGesture {
                                productoSeleccionado = producto
                                mostrarSheet = true
                            }
                        }
                        .sheet(isPresented: $mostrarSheet) {
                            if let producto = productoSeleccionado {
                                DetalleProductoView(producto: producto)
                            } else {
                                Text("Cargando...")
                            }
                        }
                        .navigationTitle("Tienda")
                }
    }
    
    /*
    func loadProductos() {
            guard let url = Bundle.main.url(forResource: "productos", withExtension: "json") else {
                print("No se pudo encontrar el archivo JSON.")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedProductos = try decoder.decode(ProductosResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.productos = decodedProductos.Productos
                }
                
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }
    
    func agregarAlCarrito(producto: Producto) {
        guard let url = Bundle.main.url(forResource: "carrito", withExtension: "json") else {
            print("No se pudo encontrar el archivo carrito.json.")
            return
        }
        
        var carrito = [Producto]()
        
        do {
            let data = try Data(contentsOf: url)
            carrito = try JSONDecoder().decode([Producto].self, from: data)
        } catch {
            print("No se pudieron cargar los productos del carrito. Usando carrito vacío.")
        }
        
        carrito.append(producto)
        
        do {
            let updatedData = try JSONEncoder().encode(carrito)
            try updatedData.write(to: url)
            print("✅ Producto añadido al carrito.")
        } catch {
            print("❌ Error al añadir producto al carrito: \(error.localizedDescription)")
        }
    }
     */
}
