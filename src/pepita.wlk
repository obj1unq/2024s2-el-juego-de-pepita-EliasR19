import wollok.game.*
import comidas.*
import positions.*
import extras.*

object pepita {
	var energia = 1000
    var property position = game.at(0,3)
    var destino = nido
    var cazador = silvestre
    var estado = viva
    
    method image(){
        /*      No permite faciles cambios a futuro si hay muchos estados
        if(self.estaEnDestino()){
            return "pepita-grande.png"
        } else {
            return "pepita.png"
        }
        */
        // return "pepita-" + self.estado().toString() + ".png"
        return "pepita-" + estado.toString() + ".png"
    }
     
//Estados
    /* Con cambio de esatdo que se calcula en el momento (Calculado)
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
    */  
    // con cambio de estado por variable (Recordado)
    method ganar() {
        estado = victoriosa
        game.say(self, "gané!")
        game.schedule(100, {game.stop() })
    
    }
    method perder() {
        estado = muerta
        game.say(self, "perdí!")
        game.schedule(100, {game.stop() })
    
        
    }
        

/// Acciones
	method energia() {
		return energia
	}

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method volar(kms) {
        self.validarVolar(kms)  
		energia = energia - self.energiaAGastar(kms)
        if(!self.puedeVolar(1)){
            self.perder()
        }
	}

    method mover(direccion){
        self.validarMover(direccion)
        self.volar(1)       //las cosas que pueden romoer hacerlas primero, si no puede volar X distancia, directamente no se mueve. Si fuera al reves se podría mover igual.
        
        position = direccion.siguiente(self.position())
        //self.estado().comprobarFinDeJuego(self)
        
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
        const siguientePos = direccion.siguiente(self.position())
        self.validarCapacidadMovimiento()
        tablero.validarDentro(siguientePos)
        self.validarAtravesables(siguientePos)
    }

    method validarAtravesables(_position){
        if(self.hayAlgoSolido(_position)){
            self.error("no puedo pasar")
        }
    }
    method hayAlgoSolido(_position){
        return game.getObjectsIn(_position).any( { cosa => cosa.esSolido()})
        
        //return game.uniqueCollider(self).esSolido()
    }

    method validarCapacidadMovimiento(){
        if(!estado.puedeMover()){
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
/*
    method comerAhi(){  /con tecla
        const comida = game.uniqueCollider(self)
        self.comer(comida)
        comida.serComida()
    }
*/
    method comerAhi(comida) {//con colisiones
        self.comer(comida)
    }

    method aplicarGravedad() {
        self.validarMover(abajo)
        position = abajo.siguiente(position)
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

}
object victoriosa {
    method puedeMover(){
        return false
    }

} 
object viva {
    method puedeMover(){
        return true
    }

    method comprobarFinDeJuego(personaje) {

    }
}