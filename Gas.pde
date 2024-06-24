public class Gas extends Element {

    Gas(int x, int y) {
        super(x, y);
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        this.grid = grid;
        this.buffer = buffer;

        // if(random(0,1) > 0.5){
        //     if(this.move(column - 1, row)){ return; }
        // }else{
        //     if(this.move(column + 1, row)){ return; }
        // }
        if(random(1) > 0.99){
            if(this.move(column - 1, row)){ return; }
        }
        if(random(1) > 0.99){
            if(this.move(column + 1, row)){ return; }
        }
        

        if (this.hasStepped() || random(1) > 0.1){ return; }
        if(this.row == 0){
            this.condense();
        }
        if (this.isCellOfType(this.column, this.row - 1, ElementType.EMPTY)){ 
            swapTo(this.column, this.row - 1);
            return; 
        }
        if (!(this.isGas(this.column, this.row - 1) || this.isCellOfType(this.column, this.row - 1, ElementType.EMPTY))){
            this.condense();
            return;
        }
        if(random(0,1) > 0.5){
            if(this.move(column - 1, row)){ return; }
        }else{
            if(this.move(column + 1, row)){ return; }
        }
        
    }
    private boolean move(int _column, int _row){
        if (this.isCellOfType(_column, _row, ElementType.EMPTY )){
            swapTo(_column, _row);
            return true; 
        }
        return false;
    }
}