public class Sand extends MovableSolid {
    
    Sand(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.SAND;
        this.weight = 5;
        this.acidRes = 95;
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        super.step(grid, buffer);

        if(random(1) > 0.8){
            if(isAdjacentToType(ElementType.LAVA)){
                this.dieAndReplace(buffer, ElementType.EMPTY);
                return;
            }
        }
    }
    
    protected color newColor(){
        float colorOffset = random(100, 150);
        return color(colorOffset, colorOffset, 0);
    }
}
