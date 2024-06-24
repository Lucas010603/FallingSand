public class Water extends Liquid {
    
    Water(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.WATER;
        this.boilingPoint = 100;
        this.viscosity = 75;
        this.acidRes = 80;
        this.evaporateType = ElementType.CLOUD;
    }
    
    protected color newColor(){
        float colorOffset = random(100, 150);
        return color(0, 0, colorOffset);
    }

    protected void receveHeat(int heat){
        if (heat >= 100){
            if(random(1) > 0.01){ return; }
            this.evaporate();
        }
    }
}
