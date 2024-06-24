public class Particle {
    int x;
    int y;
    color _color;
    int lifeSpan;
    int life;

    public Particle(int x, int y, int lifeSpan, color _color) {
        this.x = x;
        this.y = y;
        this._color = _color;
        this.lifeSpan = lifeSpan;
        this.life = 0;
    }

    public void draw() {
        fill(this._color);
        // point(this.x, this.y);
        square(this.x, this.y, 40);
    }

    public void step(){
        this.y -= Math.round(random(1,5));
        this.x += Math.round(random(-4,4));
        this.life++;
    }
}
