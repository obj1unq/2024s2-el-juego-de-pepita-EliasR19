import wollok.game.*
import comidas.*
import positions.*
import extras.*

object pepita {
	var energia = 100
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
        return "pepita" + self.estado() + ".png"
    }
     
    method estado(){
        return if(self.estaEnDestino()){
            "-grande"
        } else if(self.estaAtrapada()){
            "-gris"
        }
        else {
            ""
        }
    }
    /*
    method mover(direccion){
        position = position.up(1)
    }
    */



    method estaEnDestino(){
        return position == destino.position()
    }

    method estaAtrapada(){
        return position == cazador.position()
    }

    method mover(direccion){
        position = direccion.siguiente(self.position())
    }

    /*  No hace falta agregarle el .x() a la posicion de pepita en otro objeto  (silvestre)
    method positionX(){
        return position.x()
    }
    */

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method volar(kms) {
		energia = energia - 10 - kms 
	}
	
	method energia() {
		return energia
	}


    method text(){
        return "x: " + position.x() + "/ y: " + position.y()
    }
}

