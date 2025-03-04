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
    @Published var productosTienda: [Producto] = []
    
    init() {
        cargarJSONCarrito()
        cargarJSONProductos()
    }
    
    func obtenerUbicacionBase() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func obtenerURLArchivoProductos() -> URL {
        obtenerUbicacionBase()
            .appendingPathComponent("productos.json")
        
    }
    
    func obtenerURLArchivo() -> URL {
        obtenerUbicacionBase()
            .appendingPathComponent("carrito.json")
    }
    
    func cargarJSONCarrito(){
        let fileUbi = obtenerURLArchivo()
        print("Ruta del archivo JSON: \(fileUbi.path)")
        
        if !FileManager.default.fileExists(atPath: fileUbi.path) {
            if let bundleURL = Bundle.main.url(forResource: "carrito", withExtension: "json", subdirectory: "Datos-JSON") {
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
    
    //Funciones para los productos de la tienda
    func cargarJSONProductos(){
        let fileUbi = obtenerURLArchivoProductos()
        print("Ruta del archivo JSON: \(fileUbi.path)")
        
        if !FileManager.default.fileExists(atPath: fileUbi.path) {
            if let bundleURL = Bundle.main.url(forResource: "productos", withExtension: "json", subdirectory: "Datos-JSON") {
                do {
                    try FileManager.default.copyItem(at: bundleURL, to: fileUbi)
                } catch {
                    print("Error copiando el JSON desde el bundle: \(error)")
                }
                print("✅ Archivo encontrado en: \(bundleURL.path)")
            } else {
                print("❌ No se encontró el archivo productos.json en Datos-JSON")
            }
        }
        do {
            let data = try Data(contentsOf: fileUbi)
            let decoder = JSONDecoder()
            self.productosTienda = try decoder.decode([Producto].self, from: data)
            print("✅ Productos cargados correctamente: \(self.productosTienda)")

        } catch {
            print("Error al cargar el JSON: \(error)")
        }
    }
}
