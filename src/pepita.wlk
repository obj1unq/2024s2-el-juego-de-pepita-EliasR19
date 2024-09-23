import wollok.game.*
import comidas.*
import positions.*
import extras.*

object pepita {
	var energia = 1000
    var property position = game.at(0,3)
    var destino = nido
    var cazador = silvestre

    
    method image(){
        /*      No permite faciles cambios a futuro si hay muchos estados
        if(self.estaEnDestino()){
            return "pepita-grande.png"
        } else {
            return "pepita.png"
        }
        */
        return "pepita-" + self.estado().toString() + ".png"
    }
     
    method estado(){
        return if(self.estaEnDestino()){
            victoriosa
        } else if(self.muerta()){
            muerta
        }
        else {
           viva
        }
    }
        
	method energia() {
		return energia
	}

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method volar(kms) {
        self.validarVolar(kms)  
		energia = energia - self.energiaAGastar(kms)
	}

    method mover(direccion){
        self.validarMover(direccion)
        self.volar(1)       //las cosas que pueden romoer hacerlas primero, si no puede volar X distancia, directamente no se mueve. Si fuera al reves se podría mover igual.
        
        position = direccion.siguiente(self.position())
        self.estado().comprobarFinDeJuego(self)
    }


    //métodos booleanos

    method estaEnDestino(){
        return position == destino.position()
    }

    method estaAtrapada(){
        return position == cazador.position()
    }

    method puedeVolar(kms){
        return energia >= self.energiaAGastar(kms)
    }
    method muerta() {
        return self.estaAtrapada() || !self.puedeVolar(1) 
    }


    //


    /*  No hace falta agregarle el .x() a la posicion de pepita en otro objeto  (silvestre)
    method positionX(){
        return position.x()
    }
    */
    method validarMover(direccion){
        self.validarCapacidadMovimiento()
        tablero.validarDentro(direccion.siguiente(self.position()))

    }

    method validarCapacidadMovimiento(){
        if(!self.estado().puedeMover()){
            self.error("No puedo moverme")
        }
    }

	
    method energiaAGastar(kms){
        return 10 + kms
    }

    method validarVolar(distancia){
        if(!self.puedeVolar(distancia)){
            self.error("No tengo energia para volar")
        }
    }

    method comerAhi(){
        const comida = game.uniqueCollider(self)
        self.comer(comida)
        game.removeVisual(comida)
        //comida.serComida()
    }


    method gravedad() {
        self.validarMover(abajo)
        position = game.at(position.x(), position.y() - 1)
    }


    //Muestra cosas :)
    method text(){
        return "x: " + position.x() + "/ y: " + position.y() + "\n energia " + energia.toString()
    }

    method textColor() {
        return "00FF00FF"
    }
}

/* La validacion en una order que pasa o no pasa. No mezclar con métodos booleanos
*/

object muerta {
 
    method puedeMover(){
        return false
    }
    method comprobarFinDeJuego(personaje){
        game.say(personaje, "perdí!")
        game.stop()
    }

}
object victoriosa {
    method puedeMover(){
        return false
    }

    method comprobarFinDeJuego(personaje){
        game.say(personaje, "gané!")
        game.stop()
    }
} 
object viva {
    method puedeMover(){
        return true
    }

    method comprobarFinDeJuego(personaje) {

    }
}