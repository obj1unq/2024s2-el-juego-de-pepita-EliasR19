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

    method esSolido(){
        return false
    }

    method colisiono(pj){
        pj.perder()   
    }
}

object nido{
    var property position = game.at(8, 6)

    method image() = "nido.png"

    method esSolido(){
        return false
    }

    method colisiono(pj){
            pj.ganar()
    }
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

    method esSolido(){
        return false
    }

    method colisiono(pj){
        
    }
}

object reloj{

    var second = 0

    method text() = second.toString()

    method position() = game.at(0, 8)

    method tick() {
        second = second + 1
    }

    method esSolido(){
        return false
    }

}

object muro {

    method image() {
        return "muro.png"
    }

    method position() = game.at(5,5)

    method esSolido(){
        return true
    }
}