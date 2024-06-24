public class Cloud extends Gas {
    
    Cloud(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.CLOUD;
        this.condenseType = ElementType.WATER;
    }
    
    protected color newColor(){
        float colorOffset = random(150, 200);
        return color(colorOffset);
    }
}
