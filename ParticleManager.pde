public class ParticleManager {
    ArrayList<Particle> particles; // Initialize ArrayList

    public ParticleManager() {
        particles = new ArrayList<Particle>();
    }

    public void step() {

        for (int i = 0; i < particles.size(); i++) { 
            Particle particle = particles.get(i);
            if (particle.life >= particle.lifeSpan){
                particles.remove(i);
                continue;
            }
            particles.get(i).step();
        }
    }

    public void draw(){
        for (int i = 0; i < particles.size(); i++) { 
            particles.get(i).draw();
        }
    }

    public void add(int x, int y, color _color) {
        particles.add(new Particle(x, y, Math.round(random(5, 10)), _color)); 
    }
}