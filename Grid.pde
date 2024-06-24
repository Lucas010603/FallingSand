import java.util.Collections;
import java.util.Random;

public class Grid{
    int cellSize;
    int _width;
    int _height;
    Element[][] elements;
    Element[][] elementBuffer;
    boolean pause;
    ElementType drawSelection;
    private int[] updateSequence;
    private int updateIndex;

    Grid(){
        this.pause = false;
        this.cellSize = 7;
        this.drawSelection = ElementType.SAND;
        this._width = (int)Math.ceil((float)WINDOW_WIDTH / (float)this.cellSize);
        this._height = (int)Math.ceil((float)WINDOW_HEIGHT / (float)this.cellSize);

        this.createElements();
        this.createRandomUpdateSequence();
    }

    public void createRandomUpdateSequence(){
        Random random = new Random();
        updateSequence = new int[this._width * this._height];
        for (int i = 0; i < updateSequence.length; i++) {
            updateSequence[i] = i;
        }
        for (int i = updateSequence.length - 1; i > 0; i--) {
            int index = random.nextInt(i + 1);
            int temp = updateSequence[index];
            updateSequence[index] = updateSequence[i];
            updateSequence[i] = temp;
        }
    }

    public void createElements(){
        this.elements = new Element[this._width][this._height];
        this.elementBuffer = new Element[this._width][this._height];

        for (int i = 0; i < this._width; i++){
            for (int j = 0; j < this._height; j++){
                this.elements[i][j] = new EmptyElement(i, j);
                // this.elements[i][j] = createElement(i, j, getRandomEnum());
            }
        }
        this.elementBuffer = copyGrid(this.elements);
        this.elementBuffer = this.elements;
    }

    public void keyPressed(){
        if(key == ' '){
            this.pause = this.pause ? false : true;
        }
        if(key == 's'){
            this.drawSelection = ElementType.SAND;
        }
        if(key == 'W'){
            this.drawSelection = ElementType.WOOD;
        }
        if(key == 'w'){
            this.drawSelection = ElementType.WATER;
        }
        if(key == 'a'){
            this.drawSelection = ElementType.ACID;
        }
        if(key == 'c'){
            this.drawSelection = ElementType.CLOUD;
        }
        if(key == 'A'){
            this.drawSelection = ElementType.ACIDGAS;
        }
        if(key == 'l'){
            this.drawSelection = ElementType.LAVA;
        }
        if(key == 'S'){
            this.drawSelection = ElementType.STONE;
        }    
        if(key == 'o'){
            this.drawSelection = ElementType.OBSIDIAN;
        }
        if(key == 'L'){
            this.drawSelection = ElementType.LIFE;
        }
        if(key == '+'){
            gameSpeed = constrain(gameSpeed + 1, 1, 100);
        }
        if(key == '-'){
            gameSpeed = constrain(gameSpeed - 1, 1, 100);
        }
        if(keyCode  == 39){
            this.setpElements(true);
        }
    }

    public void mouseDown(){
        if (!mousePressed){return;}
        if (mouseButton == LEFT) { grid.placeDrawSelection(false); }
        if (mouseButton == RIGHT) { grid.placeDrawSelection(true); }
    }

    public void setpElements(){
        this.setpElements(false);
    }
    
    //fast but less accurate
    // public void setpElements(boolean force){
    //     if (this.pause && !force){return;}
    //     for (int i = 0; i < this._width; i++){
    //         for (int j = 0; j < this._height; j++){
    //             Element element = this.elements[i][j];
    //             if (element.type == ElementType.EMPTY) { continue; }
    //             element.step(this.elements, this.elementBuffer);
    //         }
    //     }
    //     this.elements = copyGrid(this.elementBuffer);
    // }


    //  slower but more accurate
    public void setpElements(boolean force){
        if (this.pause && !force) { return; }

        for (int i = 0; i < updateSequence.length; i++) {
            int index = updateSequence[i];
            int x = index % this._width;
            int y = index / this._width;

            Element element = this.elements[x][y];
            if (element.type == ElementType.EMPTY) { continue; }
            element.step(this.elements, this.elementBuffer);
        }

        this.elements = copyGrid(this.elementBuffer);
        particleManager.step();
    }


    public void drawElements(){
        noStroke();
        for (int i = 0; i < this._width; i++){
            for (int j = 0; j < this._height; j++){
                Element element = this.elements[i][j];
                if (element.type == ElementType.EMPTY){continue;}
                fill(element._color);
                square(i * this.cellSize, j * this.cellSize, this.cellSize);
            }
        }
    }

    public Element[] getCellsInSquare(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY) {
        Element[] cellsInSquare = new Element[(bottomRightX - topLeftX + 1) * (bottomRightY - topLeftY + 1)];
        int index = 0;

        for (int i = topLeftX; i <= bottomRightX; i++) {
            for (int j = topLeftY; j <= bottomRightY; j++) {
                if (i >= this.elements.length || j >= this.elements[0].length || i < 0 || j < 0) {continue;}
                cellsInSquare[index] = this.elements[i][j];
                index++;
            }
        }

        return cellsInSquare;
    }

   public void placeDrawSelection(boolean delete) {
        FunctionInput drawEmpty = createDrawingFunction((x, y) -> new EmptyElement(x, y));

        FunctionInput drawElement = createDrawingFunction((x, y) -> createElement(x, y, this.drawSelection));

        Element[] squares = this.getElementsCloseToCursor(false);
        Element[] squares_old = this.getElementsCloseToCursor(true);

        if (delete) {
            drawElementsBetweenPoints(squares, squares_old, drawEmpty);
        } else {
            drawElementsBetweenPoints(squares, squares_old, drawElement);
        }
    }

    private Element[] getElementsCloseToCursor(boolean previousFrame){
        int x = mouseX;
        int y = mouseY;
        if (previousFrame){
            x = mouseXPrev;
            y = mouseYPrev;
        }
        int diameter = round(cursorSize * this.cellSize / 2);
        PVector tl = new PVector((int)Math.round((x - diameter) / this.cellSize), (int)Math.round((y - diameter) / this.cellSize));
        PVector br = new PVector((int)Math.round((x + diameter) / this.cellSize), (int)Math.round((y + diameter) / this.cellSize));
        return this.getCellsInSquare((int)tl.x, (int)tl.y, (int)br.x, (int)br.y);
    }

    private FunctionInput createDrawingFunction(BiFunction<Integer, Integer, Element> constructor) {
        return new FunctionInput() {
            public void invoke(int x, int y) {
                Element temp = constructor.apply(x, y);
                grid.elementBuffer[x][y] = temp;
                grid.elements[x][y] = temp;
            }
        };
    }

    private void drawElementsBetweenPoints(Element[] squares, Element[] squares_old, FunctionInput drawFunction) {
        for (int i = 0; i < squares.length && i < squares_old.length; i++) {
            if (squares[i] == null || squares_old[i] == null) {
                return;
            }
            iterateAndApplyMethodBetweenTwoPoints(new PVector(squares[i].column, squares[i].row), new PVector(squares_old[i].column, squares_old[i].row), drawFunction);
        }
    }
}

