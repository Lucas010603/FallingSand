public class ImmovableSolid extends Element {

    ImmovableSolid(int x, int y) {
        super(x, y);
    }

    public void step(Element[][] grid, Element[][] buffer) {
        if (this.hasStepped()){ return; }
        this.grid = grid;
        this.buffer = buffer;
        
        if (this.onFire){
            this.heat = 100;
            this.giveOffHeat();
            float colorOffset = random(150, 200);
            this._color = color(colorOffset, 0, 0);
            if (random(1) > 0.999){
                this.dieAndReplace(buffer, ElementType.EMPTY);
            }
            if(random(1)> 0.9){
                particleManager.add(this.column * cellSize,this.row * cellSize,color(255,0,0));
            }
            if(this.isAdjacentToType(ElementType.WATER)){
                if (isSafeIndex(this.column, this.row - 1)){
                    if(this.grid[this.column][this.row - 1].heat <= 0){
                        this.onFire = false;
                        this.heat = 0;
                        this._color = newColor();
                    }
                }
            }
        }
    }
}
