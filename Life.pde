import java.util.Iterator;

public class Life extends ImmovableSolid {
    
    Life(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.LIFE;
        this.acidRes = 85;
    }

public void step(Element[][] grid, Element[][] buffer){
    if (this.hasStepped()){ return; }
    this.grid = grid;
    this.buffer = buffer;
    ArrayList<Element> toCheck = this.getAllNeighbors(true);
    toCheck.add(grid[column][row]);
    ArrayList<Element> elementsToAdd = new ArrayList<>(); // Create a list to store elements to add
    for (int index = 0; index < toCheck.size(); index++) {
        ArrayList<Element> neighbors = toCheck.get(index).getAllNeighbors(true);
        int count = 0;
        for (int i = 0; i < neighbors.size(); i++) {
            Element neighbor = neighbors.get(i);
            if (neighbor.type == ElementType.LIFE) {
                count++;
                println("here");
            }
        }
        if (toCheck.get(index).type == ElementType.LIFE) {
            if (count < 2 || count > 3) {
                toCheck.get(index).dieAndReplace(buffer, ElementType.EMPTY);
            }
            elementsToAdd.addAll(neighbors); // Add neighbors to elements to add list
        } else {
            if (count == 3) {
                toCheck.get(index).dieAndReplace(buffer, ElementType.LIFE);
            }
        }
    }
    toCheck.addAll(elementsToAdd); // Add collected elements to the original list
}


    protected color newColor(){
        float colorOffset = random(50, 100);
        return color(0, colorOffset, colorOffset);
    }

}
