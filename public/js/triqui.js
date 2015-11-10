var juego1 = [
    [1, 0, null],
    [1, null, 0],
    [1, null, null]
];

var juego2 = [
    [1, 0, null],
    [0, 1, 0],
    [0, null, 1]
];

var juego3 = [
    [1, 0, null],
    [null, 0, 0],
    [1, 1, 1]
];

var juego4 = [
    [1, 0, 1],
    [1, 0, 0],
    [0, 1, 1]
];

var juego5 = [
    [1, 0, null],
    [null, null, null],
    [null, null, null]
];

function gano(juego, x, y) {
    function gano(p) {
        var i = j = contador = 0;
        var gano = false;
        //horizontal
        while (!gano && i < 3) {
            j = 0;
            while (!gano && j < 3) {
                if (juego[i][j] == p) {
                    contador++;
                } else {
                    contador = 0;
                    break;
                }
                if (contador == 3) {
                    gano = true;
                }
                j++;
            }
            i++;
        }
        i = j = contador = 0;
        // vertical
        while (!gano && i < 3) {
            j = 0;
            while (!gano && j < 3) {
                if (juego[j][i] == p) {
                    contador++;
                } else {
                    contador = 0;
                    break;
                }
                if (contador == 3) {
                    gano = true;
                }
                j++;
            }
            i++;
        }
        i = j = contador = 0;
        corresponde = true;
        //diagonal principal
        while (!gano && corresponde && i < 3) {
            if (juego[i][j] == p) {
                contador++;
                j++;
                i++;
            } else {
                corresponde = false;
            }
            if (contador == 3) {
                gano = true;
            }

        }
        //diagonal 2
        i = j = contador = 0;
        corresponde = true;
        while (!gano && corresponde && i < 3) {
            if (juego[i][2 - j] == p) {
                contador++;
                j++;
                i++;
            } else {
                corresponde = false;
            }
            if (contador == 3) {
                gano = true;
            }
        }
        return gano;
    }

    function isFull(juego){
        var isNull = false;
        var j = i = 0;
        while(!isNull && i<3){
            while(!isNull && j<3){
                if(juego[i][j]==null){
                    isNull = true;
                    return false;
                }
                i++;
                j++;
            }
        }
        return true;
    }

    if(gano(x)){
        return x;
    }else if(gano(y)){
        return y;
    }else if(!isFull(juego)){
        return "pasos disponibles";
    }else{
        return "empate";
    }
}
