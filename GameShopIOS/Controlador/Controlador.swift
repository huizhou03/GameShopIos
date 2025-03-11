//
//  Controlador.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 4/3/25.
//
import SwiftUI
import Foundation

class GestorDatos: ObservableObject {
    @Published var carrito = [ItemCarrito]()
    @Published var productos = [Producto]()
    
    
    init() {}
    
    func obtenerUbicacionBase() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func obtenerURLArchivo() -> URL {
        obtenerUbicacionBase()
            .appendingPathComponent("carrito.json")
    }
    
    func cargarJSONCarrito(correoUsuario: String) {
        let fileUbi = obtenerURLArchivo()
        print("Ruta del archivo JSON: \(fileUbi.path)")

        // Verificar si el archivo existe
        if !FileManager.default.fileExists(atPath: fileUbi.path) {
            if let bundleURL = Bundle.main.url(forResource: "carrito", withExtension: "json") {
                do {
                    try FileManager.default.copyItem(at: bundleURL, to: fileUbi)
                } catch {
                    print("Error copiando el JSON desde el bundle: \(error)")
                }
            }
        }
        
        do {
            let data = try Data(contentsOf: fileUbi)
            let decoder = JSONDecoder()
            let carritoCompleto = try decoder.decode([ItemCarrito].self, from: data)

            // Filtrar solo los productos del usuario
            self.carrito = carritoCompleto.filter { $0.correoUsuario == correoUsuario }

            // Verificar si se cargan más productos
            print("Productos cargados para \(correoUsuario): \(self.carrito.count)")

        } catch {
            print("Error al cargar el JSON: \(error)")
        }
    }


    
    func guardarDatosJSONCarrito() {
        let fileUbi = obtenerURLArchivo()
        
        // Imprimir el contenido del carrito antes de guardarlo
        print("Carrito antes de guardar: \(self.carrito)")

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(carrito)  // Asegúrate de que 'carrito' contiene todos los productos

            // Imprimir los datos que se van a guardar
            print("Datos a guardar: \(String(data: data, encoding: .utf8) ?? "")")

            try data.write(to: fileUbi, options: .atomicWrite)  // Escribe los datos al archivo
        } catch {
            print("Error al guardar los datos: \(error)")
        }
    }
    
    
    func agregarProductoAlCarrito(producto: Producto, correoUsuario: String) {
        // Cargar el carrito desde el archivo (si no se ha cargado ya)
        if carrito.isEmpty {
            cargarJSONCarrito(correoUsuario: correoUsuario)
        }
        
        // Verificar si el producto ya existe en el carrito
        if let index = carrito.firstIndex(where: { $0.producto.id == producto.id && $0.correoUsuario == correoUsuario }) {
            // Si existe, aumentar la cantidad
            carrito[index].cantidad += 1
        } else {
            // Si no existe, agregar un nuevo producto al carrito
            let nuevoItem = ItemCarrito(producto: producto, cantidad: 1, correoUsuario: correoUsuario)
            carrito.append(nuevoItem)
        }
        
        // Guardar los datos actualizados en el JSON solo si hay cambios
        guardarDatosJSONCarrito()
    }

    
    func borrarProduto(at indexSet: IndexSet) {
        carrito.remove(atOffsets: indexSet)
        guardarDatosJSONCarrito()
    }
    
    //Funcion de la tienda
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
}
