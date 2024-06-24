public class Stone extends MovableSolid {
    
    Stone(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.STONE;
        this.weight = 5;
        this.acidRes = 98;
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        super.step(grid, buffer);

        if(random(1) > 0.993){
            if(isAdjacentToType(ElementType.LAVA)){
                this.dieAndReplace(buffer, ElementType.LAVA);
                return;
            }
        }
    }
    
    protected color newColor(){
        float colorOffset = random(80, 120);
        return color(colorOffset);
    }
}
