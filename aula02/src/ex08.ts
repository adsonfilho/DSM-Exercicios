class Point {
    x: number;
    y: number;

    constructor(x: number, y: number) {
        this.x = x;
        this.y = y;
    }

    distance(ponto: Point): number{
        return Math.sqrt(Math.pow(ponto.x - this.x, 2) + Math.pow(ponto.y - this.y, 2));
    }
}

class Rectangle {
    inferiorEsquerdo: Point;
    superiorDireito: Point;

    constructor(inferiorEsquerdo: Point, superiorDireito: Point) {
        this.inferiorEsquerdo = inferiorEsquerdo;
        this.superiorDireito = superiorDireito;
    }

    area(): number {
        return Math.abs(this.inferiorEsquerdo.x - this.superiorDireito.x) * Math.abs(this.inferiorEsquerdo.y - this.superiorDireito.y);
    }
}

const sd = new Point(3,5);
const ie = new Point(1,2);
//observe que o construtor da classe Rectangle
//recebe dois objetos do tipo Point como parâmetro
const r = new Rectangle(ie,sd);
console.log("Área:", r.area());
