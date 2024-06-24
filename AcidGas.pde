public class AcidGas extends Gas {
    
    AcidGas(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.ACIDGAS;
        this.condenseType = ElementType.ACID;
        this.acidRes = 100;
    }
    
    protected color newColor(){
        float colorOffset = random(150, 200);
        return color(0, colorOffset, 0);
    }
}
