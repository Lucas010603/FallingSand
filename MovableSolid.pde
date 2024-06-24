public class MovableSolid extends Element {

    MovableSolid(int x, int y) {
        super(x, y);
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        this.grid = grid;
        this.buffer = buffer;

        if (this.hasStepped()){ return; }
        if (move(column, row + 1)){ return; }
        if (random(1) > 0.5){  if(move(column - 1, row + 1)){return;}
        }else{ if(move(column + 1, row + 1)){return;} }
    }

    private boolean move(int _column, int _row){
        boolean liquid = isLiquid(_column, _row);
        if (this.isCellOfType(_column, _row, ElementType.EMPTY ) || liquid){
            if (random(1) > (this.getProbability(grid[_column][_row].viscosity - this.weight)) && liquid) {
                return false;
            }

            if(liquid){this.spawnParticles(grid[_column][_row].newColor());}
            swapTo(_column, _row);
            return true; 
        }
        return false;
    }

    protected void spawnParticles(color _color){
        particleManager.add(this.column * cellSize, this.row * cellSize, _color);
    }
}