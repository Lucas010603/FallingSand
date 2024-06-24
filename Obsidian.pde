public class Obsidian extends ImmovableSolid {
    
    Obsidian(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.OBSIDIAN;
        this.acidRes = 99;
    }

    protected color newColor(){
        float colorOffset = random(15, 20);
        return color(colorOffset);
    }
}
