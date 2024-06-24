import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;
import java.util.function.BiFunction;

Grid grid;
int WINDOW_WIDTH;
int WINDOW_HEIGHT;
int cursorSize;
int mouseXPrev;
int mouseYPrev;
int gameSpeed = 1;
int cellSize;
ParticleManager particleManager;

Element[][] copyGrid(Element[][] original) {
  Element[][] copy = new Element[original.length][original[0].length];
  for (int i = 0; i < original.length; i++) {
    copy[i] = original[i].clone();
  }
  return copy;
}

void init(){
  mouseXPrev = mouseX;
  mouseYPrev = mouseY;
  WINDOW_WIDTH = width;
  WINDOW_HEIGHT = height;
  grid = new Grid();
  // println(grid instanceof Grid);
  cellSize = grid.cellSize;
  cursorSize = 0;
  particleManager = new ParticleManager();
  
}

public static void swapElements(Element[][] elements, int col1, int row1, int col2, int row2) {
    Element element1 = elements[col1][row1];
    Element element2 = elements[col2][row2];

    elements[col1][row1] = element2;
    elements[col2][row2] = element1;

    int tempColumn = element1.column;
    int tempRow = element1.row;
    element1.column = element2.column;
    element1.row = element2.row;
    element2.column = tempColumn;
    element2.row = tempRow;
}

interface FunctionInput {
    void invoke(int x, int y);
}

void iterateAndApplyMethodBetweenTwoPoints(PVector pos1, PVector pos2, FunctionInput function) {
    // If the two points are the same, execute the function at that point
    if (pos1.equals(pos2)) {
        function.invoke((int) pos1.x, (int) pos1.y);
        return;
    }

    // Bresenham's line algorithm to iterate between the two points
    int x0 = (int) pos1.x;
    int y0 = (int) pos1.y;
    int x1 = (int) pos2.x;
    int y1 = (int) pos2.y;

    int dx = abs(x1 - x0);
    int dy = abs(y1 - y0);
    int sx = x0 < x1 ? 1 : -1;
    int sy = y0 < y1 ? 1 : -1;
    int err = dx - dy;

    while (true) {
        function.invoke(x0, y0); // Execute the function at the current point

        if (x0 == x1 && y0 == y1) break;
        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x0 += sx;
        }
        if (e2 < dx) {
            err += dx;
            y0 += sy;
        }
    }
}

int avrage(int num, int num2){
    return Math.round((num + num2) / 2);
}