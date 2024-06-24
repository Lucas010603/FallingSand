public class Element{
    protected int column;
    protected int row;
    public color _color = color(0);
    public ElementType type = ElementType.EMPTY;
    protected Element[][] grid;
    protected Element[][] buffer;
    protected int viscosity;
    protected int boilingPoint;
    protected int weight;
    protected int acidRes = 0;
    protected ElementType condenseType;
    protected ElementType evaporateType;
    protected boolean onFire = false;
    protected int heat = 0;
    
    Element(int x, int y) {
        this.column = x;
        this.row = y;
    }
    
    protected void step(Element[][] grid, Element[][] buffer) {}
    
    protected color newColor() {
        return color(0);
    }
    
    
    
    protected boolean hasStepped() {
        if (this.grid == null) {return false;}
        return !(this.grid[column][row] == this.buffer[column][row]);
    }
    
    protected boolean isLiquid(int _column, int _row) {
        if (!isSafeIndex(_column, _row)) {return false;}
        return this.grid[_column][_row] instanceof Liquid;
    }
    protected boolean isGas(int _column, int _row) {
        if (!isSafeIndex(_column, _row)) {return false;}
        return this.grid[_column][_row] instanceof Gas;
    }
    
    protected boolean isCellOfType(int _column, int _row, ElementType type) {
        if (!isSafeIndex(_column, _row)) {return false;}
        return this.grid[_column][_row].type == type;
        
    }
    
    protected boolean isCellOfType(ElementType type) {
        return this.isCellOfType(this.column, this.row, type);
    }
    
    protected boolean isSafeIndex(int _column, int _row) {
        if (this.grid == null) {return false;}
        return !(_column >= this.grid.length || _row >= this.grid[0].length || _column < 0 || _row < 0);
    }
    
    protected void swapTo(int col2, int row2) {
        Element element1 = this.buffer[column][row];
        Element element2 = this.buffer[col2][row2];
        
        this.buffer[column][row] = element2;
        this.buffer[col2][row2] = element1;
        
        int tempColumn = element1.column;
        int tempRow = element1.row;
        element1.column = element2.column;
        element1.row = element2.row;
        element2.column = tempColumn;
        element2.row = tempRow;
    }
    
    protected float getProbability(int value) {
        return map(value, 1, 100, 1, 0);
    }
    
    protected ArrayList<Element> getNeighbors() {
        return this.getNeighbors(false);
    }
    
    protected ArrayList<Element> getNeighbors(boolean withEmpty) {
        int[][] lookup = {{0, 1} , {1, 0} , { - 1, 0} , { - 1, 1} , {0, -1} , {1, -1} };
        ArrayList<Element> result = new ArrayList<>();
        for (int[] offset : lookup) {
            int offsetX = offset[0];
            int offsetY = offset[1];
            if (!isSafeIndex(column + offsetX, row + offsetY)) {
                continue;
            }
            if (this.buffer[column + offsetX][row + offsetY].type == ElementType.EMPTY && !withEmpty) {
                continue;
            }
            result.add(this.buffer[column + offsetX][row + offsetY]);
        }
        return result;
    }
    
    protected ArrayList<Element> getAllNeighbors(boolean withEmpty) {
        int[][] lookup = {{ - 1, -1} ,{1,1} ,{0, 1} , {1, 0} , { - 1, 0} , { - 1, 1} , {0, -1} , {1, -1} };
        ArrayList<Element> result = new ArrayList<>();
        for (int[] offset : lookup) {
            int offsetX = offset[0];
            int offsetY = offset[1];
            if (!isSafeIndex(column + offsetX, row + offsetY)) {
                continue;
            }
            if (this.buffer[column + offsetX][row + offsetY].type == ElementType.EMPTY && !withEmpty) {
                continue;
            }
            result.add(this.buffer[column + offsetX][row + offsetY]);
        }
        return result;
    }
    
    protected void corrodeNeighbors(Element[][] _buffer) {
        ArrayList<Element> neighbors = this.getNeighbors();
        boolean hasCorroded = false;
        for (int i = 0; i < neighbors.size(); i++) {
            if (neighbors.get(i).corrode(_buffer)) {
                hasCorroded = true;
            }
        }
        if (random(1) > 0.7 && hasCorroded) {
            _buffer[this.column][this.row] = new EmptyElement(this.column, this.row);
        }
    }
    
    protected boolean isAdjacentToType(ElementType type) {
        ArrayList<Element> neighbors = this.getNeighbors(true);
        boolean _result = false;
        for (int i = 0; i < neighbors.size(); i++) {
            Element neighbor = neighbors.get(i);
            if (this.isCellOfType(neighbor.column, neighbor.row, type)) {
                _result = true;
            }
        }
        return _result;
    }
    
    protected boolean isOnlyAdjacentToType(ElementType type) {
        ArrayList<Element> neighbors = this.getNeighbors(true);
        boolean _result = true;
        for (int i = 0; i < neighbors.size(); i++) {
            Element neighbor = neighbors.get(i);
            if (!this.isCellOfType(neighbor.column, neighbor.row, type)) {
                _result = false;
            }
        }
        return _result;
    }
    
    
    protected void giveOffHeat() {
        ArrayList<Element> neighbors = this.getNeighbors();
        boolean hasCorroded = false;
        for (int i = 0; i < neighbors.size(); i++) {
            neighbors.get(i).receveHeat(this.heat);
        }
    }
    
    protected boolean corrode(Element[][] _buffer) {
        if (random(1) > this.getProbability(this.acidRes)) {return false;}
        _buffer[this.column][this.row] = new EmptyElement(this.column, this.row);
        return true;
    }
    
    protected int maxMove(int xDif, int yDif, int limit, int lowerLimit) {
        int maxMoves = lowerLimit;
        for (int i = lowerLimit; i < limit; i++) {
            if (!this.isSafeIndex(column + xDif * i, row + yDif * i)) {return maxMoves;}
            if (this.buffer[column + xDif * i][row + yDif * i].type == ElementType.EMPTY && this.grid[column + xDif * i][row + yDif * i].type == ElementType.EMPTY) {
                                maxMoves++;
                                continue;
            }
            return maxMoves;
        }
        return maxMoves;
    }
    
    protected void condense() {
        this.buffer[this.column][this.row] = createElement(this.column, this.row, this.condenseType);
    }
    
    protected void evaporate() {
        if (this.buffer == null) {return;}
        this.buffer[this.column][this.row] = createElement(this.column, this.row, this.evaporateType);
    }
    
    protected void receveHeat(int heat) {
    }
    
    protected void dieAndReplace(Element[][] _buffer, ElementType element) {
        _buffer[this.column][this.row] = createElement(this.column, this.row, element);
    }
}

