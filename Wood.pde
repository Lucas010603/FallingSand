public class Wood extends ImmovableSolid {
    
    Wood(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.WOOD;
        this.acidRes = 85;
    }

    protected color newColor(){
        float colorOffset = random(20, 40);
        return color(101 - colorOffset, 67 - colorOffset, 33 - colorOffset);
    }

    protected void receveHeat(int heat){
        if (heat >= 100){
            if(random(1) > 0.1 || !this.isAdjacentToType(ElementType.EMPTY)){ return; }
            this.onFire = true;
        }
    }
}
