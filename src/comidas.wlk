import wollok.game.*

object manzana {
	const base= 5
	var madurez = 1
	
	method energiaQueOtorga() {
		return base * madurez	
	}
	
	method madurar() {
		madurez = madurez + 1
		//madurez += 1
	}

    method position() = game.at(3,5)
    method image() = "manzana.png"

    method serComida(){
        game.removeVisual(self)
    }

}

object alpiste {

	method energiaQueOtorga() {
		return 20
	} 

    method position() = game.at(7,8)

    method image() = "alpiste.png"

     method serComida(){
        game.removeVisual(self)
    }


}

