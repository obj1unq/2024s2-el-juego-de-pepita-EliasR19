import pepita.*
import game.*

object silvestre{

    var presa = pepita

    method position(){
        return (game.at(presa.position().x().max(2), 0))
        // silvestre se queda en x = 3
    }

    method image() = "silvestre.png"


    method estaPermitido() {
        return self.position()
    }
}

object nido{
    var property position = game.at(8, 6)

    method image() = "nido.png"
}


object fondo {

    method position() = game.origin()

    var escenario = 0

    method image() {
        return "fondo" + escenario + ".jpg"
    }

    method cambiar(){
        escenario = (escenario + 1 ) % 2
    }
}