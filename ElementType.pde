public enum ElementType{
    EMPTY,
    SAND,
    WATER,
    CLOUD,
    WOOD,
    ACID,
    ACIDGAS,
    LAVA,
    STONE,
    OBSIDIAN,
    LIFE
};

Element createElement(int x, int y, ElementType type) {
    switch (type) {
        case EMPTY:
            return new EmptyElement(x, y);
        case SAND:
            return new Sand(x, y);
        case WOOD:
            return new Wood(x, y);
        case WATER:
            return new Water(x, y);
        case ACID:
            return new Acid(x, y);
        case CLOUD:
            return new Cloud(x, y);
        case ACIDGAS:
            return new AcidGas(x, y);
        case LAVA:
            return new Lava(x, y);
        case STONE:
            return new Stone(x, y);
        case OBSIDIAN:
            return new Obsidian(x, y);
        case LIFE:
            return new Life(x, y);
        default:
            return null;
    }
}

String getTypeAsString(ElementType type) {
    switch (type) {
        case EMPTY:
            return "empty";
        case SAND:
            return "sand";
        case WOOD:
            return "wood";
        case WATER:
            return "water";
        case ACID:
            return "acid";
        case CLOUD:
            return "cloud";
        case ACIDGAS:
            return "acid gas";
        case LAVA:
            return "lava";
        case STONE:
            return "stone";
        case OBSIDIAN:
            return "obsidian";
        case LIFE:
            return "life";
        default:
            return "";
    }
}


ElementType getRandomEnum() {
  // Get all enum values
  ElementType[] values = ElementType.values();
  
  // Generate a random index
  int randomIndex = (int) random(0, values.length);
//   if (randomIndex == 5 ){return getRandomEnum();}
  // Return the enum value at the random index
  return values[randomIndex];
}