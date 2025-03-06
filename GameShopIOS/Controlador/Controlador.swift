//
//  Controlador.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 4/3/25.
//
import SwiftUI
import Foundation

class GestorDatos: ObservableObject {
    @Published var carrito: [Producto] = []
    @Published var productos = [Producto]()
    
    init() {
        cargarJSONCarrito()
        loadProductos()
    }
    
    func obtenerUbicacionBase() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func obtenerURLArchivo() -> URL {
        obtenerUbicacionBase()
            .appendingPathComponent("carrito.json")
    }
    
    func cargarJSONCarrito(){
        let fileUbi = obtenerURLArchivo()
        print("Ruta del archivo JSON: \(fileUbi.path)")
        
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
            self.carrito = try decoder.decode([Producto].self, from: data)
        } catch {
            print("Error al cargar el JSON: \(error)")
        }
    }
    func guardarDatosJSONCarrito(){
        let fileUbi = obtenerURLArchivo()
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(carrito)
            try data.write(to: fileUbi, options: .atomicWrite)
        } catch {
            print("Error al guardar los datos")
        }
    }
    
    func agregarProductoAlCarrito(producto: Producto) {
        carrito.append(producto)
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
