// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk



// es groso depende de su rol
//orcos
//humanos
//sonPersonales

//fuerza, inteligencia y un rol (todos)

//hasta la tercera oracion 

//apartir d euna clase creas una instancia de ese objeto

//setear pisar el valor de la variable

//ademas de modificarlo

//superclase
class Personaje {
  const property fuerza
  const inteligencia
  var property rol //polimorfismo

  method potencialOfensivo() {
    return fuerza * 10 + rol.extra()
  }

  method esGroso() {
    return self.esInteligente() or rol.esGroso(self)//en rol
  }

  //recurso nuevo
  //metodo de indicacion no tiene return
  //metodo abstracto, si tiene como minimo uno
  //no se puede instanciar
  method esInteligente()

  //const unHumano = new Personaje(fuerza=0, inteligencia=o, rol=brujo)
  //error es una clase abstracta no puede instanciarse

  method cambiarRol(nuevoRol) {
    self.rol(nuevoRol)
  }
}


class Humano inherits Personaje{
  override method esInteligente()= inteligencia > 50
}

class Orco inherits Personaje{
  override method potencialOfensivo(){
    return if(rol.toString() == brujo.toString()) super() * 1.1 else super()
  }
  override method esInteligente()= false
}


//ojo el cazador ouede tener diferentes mascotas
//es una clase
class Cazador{
  const mascota
  method extra() = mascota.extraPotencialOfensivo()
  method esGroso(unPersonaje) = mascota.esLongeva()
}

//es una clase porque tiene diferentes tipos de mascotas
class Mascota{
  //r
  const fuerza
  var edad
  const garras //bool
  method cumplirAnios() {
    edad += 1
  }
  method extraPotencialOfensivo() = if(garras) fuerza*2 else fuerza

  method esLongeva()= edad > 10

}

object noTieneMascota{
  //r
  method extraPotencialOfensivo() = 0
  method esLongeva()=false
}

object guerrero{
  method extra() = 100
  method esGroso(unPersonaje) = unPersonaje.fuerza()>50
}

object brujo{
  method extra() {}
  method esGroso(unPersonaje) = true
}


class Localidad{
  var ejercito
  method poderOfensivo() = ejercito.poderOfensivo()

  method serOcupada(unEjercito){
    
  }
}


class Aldea inherits Localidad{

  const maxTropa //deberia ser mayor a 10

  method initialize(){
    if(maxTropa < 10){
      self.error("la poblacion debe ser mayor a 10")
    }
  }

  //le pasamos el objeto completo
  override method serOcupada(unEjercito){
    if(maxTropa < unEjercito.tamano()){
      ejercito = new Ejercito(tropa=unEjercito.losMasPoderoso())
      unEjercito.quitarLosMasFuerte(ejercito)
      ejercito = unEjercito.ejercitoMasFuerte()
    }
    else {
      ejercito = unEjercito
    }
  }

  
}

class Ciudad inherits Localidad{
  override method poderOfensivo()= super()+300
  override method serOcupada(unEjercito){
    ejercito = unEjercito
  }
}


//validar que el ejercito tenga minimo 10
class Ejercito {
  const tropa = []

  method poderOfensivo()= tropa.sum({p=>p.potencialOfensivo()})

  method invadir(unaLocalidad){
    if(self.puedeInvadir(unaLocalidad)){
      unaLocalidad.serOcupada(self)
    }
  }

  method puedeInvadir(unaLocalidad){
    return self.poderOfensivo() > unaLocalidad.poderDefensivo()
  }

  method tamano()= tropa.size()

  method losMasPoderoso() = self.ordenadosLosMasPoderoso().take(10)

  method ordenadosLosMasPoderoso()= tropa.sortBy({t1,t2 => t1.potencialOfensivo() > t2.potencialOfensivo()})

  method quitarLosMasFuerte(ejercito){
    tropa.removeAll(self.losMasPoderoso())
  }
}