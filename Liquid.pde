public class Liquid extends Element {

    Liquid(int x, int y) {
        super(x, y);
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        this.grid = grid;
        this.buffer = buffer;
        
        if (this.heat > 0){
            this.giveOffHeat();
        }
        if (this.hasStepped()){ return; }
        if (this.isCellOfType(column, row + 1, ElementType.EMPTY)){ 
            swapTo(this.column, this.row + 1);
            return; 
        }
        
        if(random(1) > 0.5){
            if(this.move(column - 1, row)){ return; }
        }else{
            if(this.move(column + 1, row)){ return; }
        }
        // if(random(1) > map(this.boilingPoint, 1, 101, 0, 1)){
        //     if(this.isCellOfType(column, row - 1, ElementType.EMPTY)){
        //         this.evaporate();
        //     }
        // }
        

    }


    private boolean move(int _column, int _row){
        boolean liquid = isLiquid(_column, _row);
        if (this.isCellOfType(_column, _row, ElementType.EMPTY ) || liquid){
            if(liquid && random(1) > 0.1){return false;}
            if (random(1) > (this.getProbability(avrage(grid[_column][_row].viscosity, grid[column][row].viscosity))) && liquid) {
                return false;
            }
            swapTo(_column, _row);
            return true; 
        }
        return false;
    }
}