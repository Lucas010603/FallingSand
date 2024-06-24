public class Lava extends Liquid {
    
    Lava(int x, int y){
        super(x, y);
        this._color = this.newColor();
        this.type = ElementType.LAVA;
        this.boilingPoint = 3000;
        this.viscosity = 99;
        this.acidRes = 99;
        this.evaporateType = ElementType.LAVA;
        this.heat = 2000;
    }

    protected void step(Element[][] grid, Element[][] buffer) {
        super.step(grid, buffer);
        if (this.hasStepped()){return;}
        if(random(1) > 0.9){
            if(isAdjacentToType(ElementType.WATER)){
                if(random(1) > 0.9){
                    this.dieAndReplace(buffer, ElementType.OBSIDIAN);
                }else{
                    this.dieAndReplace(buffer, ElementType.STONE);
                }
                return;
            }
        }
        if(random(1) > 0.99){
            if(isAdjacentToType(ElementType.OBSIDIAN)){
                this.dieAndReplace(buffer, ElementType.OBSIDIAN);
                return;
            }
        }
    }
    
    protected color newColor(){
        float colorOffset = random(100, 150);
        return color(colorOffset, 0, 0);
    }
}
