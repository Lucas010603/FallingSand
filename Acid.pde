public class Acid extends Liquid {
    
    Acid(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.ACID;
        this.boilingPoint = 100;
        this.viscosity = 90;
        this.evaporateType = ElementType.ACIDGAS;
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        super.step(grid, buffer);
        if(grid[column][row] == buffer[column][row]){
            this.corrodeNeighbors(buffer);

        }
    }
    
    protected color newColor(){
        float colorOffset = random(100, 150);
        return color(0, colorOffset, 0);
    }

    protected boolean corrode(Element[][] _buffer){
        return false;
    }

    protected void receveHeat(int heat){
        if (heat >= 100){
            if(random(1) > 0.01){ return; }
            this.evaporate();
        }
    }

}
