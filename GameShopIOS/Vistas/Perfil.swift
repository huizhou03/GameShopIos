//
//  Perfil.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 6/3/25.
//
import SwiftUI
import PhotosUI

/*//JSON
struct PerfilUsuario: Codable{
    var id: String
    var nombre: String
    var correo: String
    var dirPostal: String
    var newsletter: Bool
}*/

/*
 struct Perfil: View {
 let nombreUsuario: String
 @State private var imagenPerfil: UIImage? = UIImage(named: "perfilDefecto")
 //@State private var perfilUsuario: Usuario?
 @State private var mostrarImagen: Bool = false
 
 /*@State var nombre: String = ""
  @State var direccionPostal: String = ""
  @State var correo: String = ""
  @State var newsletterActivado: Bool = false*/
 
 var body: some View {
 VStack{
 Button(action: { mostrarImagen.toggle() }) {
 if let imagen = imagenPerfil {
 Image(uiImage: imagen)
 .resizable()
 .scaledToFit()
 .frame(width: 120, height: 120)
 .clipShape(Circle())
 .overlay(Circle().stroke(Color.gray, lineWidth: 2))
 }
 }
 .sheet(isPresented: $mostrarImagen) {
 ElegirImagen(image: $imagenPerfil)
 }
 
 Form {
 Section(header: Text("Perfil")) {
 TextField("Nombre", text: Binding(
 get: { perfilUsuario?.nombre ?? "" },
 set: { nuevoValor in perfilUsuario?.nombre = nuevoValor }
 ))
 TextField("Dirección Postal", text: Binding(
 get: { perfilUsuario?.dirPostal ?? "" },
 set: { nuevoValor in perfilUsuario?.dirPostal = nuevoValor }
 ))
 TextField("Correo", text: .constant(perfilUsuario?.correo ?? ""))
 .disabled(true)
 }
 
 Toggle("Suscribirse a la Newsletter", isOn: Binding(
 get: { perfilUsuario?.newsletter ?? false },
 set: { nuevoValor in perfilUsuario?.newsletter = nuevoValor }
 ))
 
 Button(action: cerrarSesion) {
 Text("Cerrar sesión").foregroundColor(.red)
 }
 }
 }
 .navigationTitle("PERFIL")
 .onAppear(perform: cargarDatosUsuario)
 }
 
 private func cargarDatosUsuario() {
 perfilUsuario = GestorUsuarios.encontrarUsuario(por: nombreUsuario)
 }
 
 func cerrarSesion() {
 print("Usuario ha cerrado sesión")
 }
 }
 
 struct ElegirImagen: UIViewControllerRepresentable {
 @Binding var image: UIImage?
 
 class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 var parent: ElegirImagen
 
 init(parent: ElegirImagen) {
 self.parent = parent
 }
 
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 if let uiImage = info[.originalImage] as? UIImage {
 parent.image = uiImage
 }
 picker.dismiss(animated: true)
 }
 }
 
 func makeCoordinator() -> Coordinator {
 Coordinator(parent: self)
 }
 
 func makeUIViewController(context: Context) -> UIImagePickerController {
 let picker = UIImagePickerController()
 picker.delegate = context.coordinator
 picker.sourceType = .photoLibrary
 return picker
 }
 
 func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
 }
 
 /*TextField ("Nombre", text: $nombre)
  .font(.headline)
  .padding()
  .background(Color.gray.opacity(0.2))
  .cornerRadius(6)
  .padding(.horizontal, 60)
  .foregroundStyle(Color.black)
  
  TextField ("Dirección Postal", text: $direccionPostal)
  .font(.headline)
  .padding()
  .background(Color.gray.opacity(0.2))
  .cornerRadius(6)
  .padding(.horizontal, 60)
  .foregroundStyle(Color.black)
  
  TextField ("Correo", text: $correo)
  .keyboardType(.emailAddress)
  .disableAutocorrection(true)
  .autocapitalization(.none)
  .font(.headline)
  .padding()
  .background(Color.gray.opacity(0.2))
  .cornerRadius(6)
  .padding(.horizontal, 60)
  .foregroundStyle(Color.black)
  .disabled(true)//Email no editable
  
  Toggle("Newsletter: ", isOn: $newsletterActivado)
  .padding(.horizontal, 60)
  
  Button("Cerrar sesión", action: cerrarSesion)
  .padding()
  .background()
  .foregroundColor(.white)
  .cornerRadius(6)
  }
  .navigationTitle("PERFIL")
  .onAppear(perform: cargarDatosUsuario)
  }
  
  // Cargar los datos del usuario desde el archivo usuarios.json
  private func cargarDatosUsuario() {
  if let usuario = GestorUsuarios.encontrarUsuario(por: nombreUsuario) {
  usuarioAutenticado = usuario
  }
  }*/
 /*func cargarDatosUsuario() {
  if let url = Bundle.main.url(forResource: "userData", withExtension: "json"),
  let data = try? Data(contentsOf: url),
  let decodedUsers = try? JSONDecoder().decode([String: [PerfilUsuario]].self, from: data),
  let usuarios = decodedUsers["Usuarios"],
  let primerUsuario = usuarios.first {
  
  /*perfilUsuario = primerUsuario
   nombre = primerUsuario.nombre
   direccionPostal = primerUsuario.dirPostal
   correo = primerUsuario.correo
   newsletterActivado = primerUsuario.newsletter*/
  }
  }*/
 
 
 /*
  .padding()
  .onAppear {
  // Cargar los usuarios desde el archivo JSON al iniciar la vista
  cargarUsuarios()
  }
  // Método para cargar los usuarios desde el archivo JSON
  private func cargarUsuarios() {
  if let url = Bundle.main.url(forResource: "usuarios", withExtension: "json") {
  do {
  let data = try Data(contentsOf: url)
  let decoder = JSONDecoder()
  let response = try decoder.decode(UsuariosResponse.self, from: data)
  usuariosDetalles = response.Usuarios
  print("Usuarios cargados desde el archivo JSON.")
  } catch {
  print("Error al cargar el archivo JSON: \(error)")
  }
  } else {
  print("No se encontró el archivo JSON.")
  }
  }
  
  // Método de autenticación
  private func autenticar() {
  // Verificar si los campos no están vacíos
  guard !usr.isEmpty, !pwd.isEmpty else {
  print("Error: Completa los campos de usuario y contraseña")
  sesionFallida = true
  return
  }
  
  // Buscar si el usuario existe en el array de usuarios con los detalles cargados desde JSON
  if let usuario = usuariosDetalles.first(where: { $0.correo == usr }) {
  // Si el correo coincide, verifica la contraseña (puedes agregar una lógica de contraseña si es necesario)
  if pwd == "123456" { // Aquí solo es un ejemplo de contraseña
  print("Inicio de sesión exitoso para \(usuario.nombre)")
  autenticado = true
  sesionFallida = false
  } else {
  print("Contraseña incorrecta para \(usuario.nombre).")
  sesionFallida = true
  }
  } else {
  print("Error: Usuario no encontrado.")
  sesionFallida = true
  }
  
  // Mostrar los valores para depuración
  print("**********")
  print("Inicio de sesión")
  print(" 👤 Usuario: \(usr)")
  print(" 🔑 Contraseña: \(pwd)")
  }*/
 */
