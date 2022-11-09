class Spell{
    String name;
    int damage;
    char type;
    String flavor;
    boolean available;
    State state;

    Spell(String encoded){
        String parts[] = encoded.split(";");
        name = parts[0];
        damage = parseInt(parts[1]);
        type = parts[2].charAt(0);
        flavor = parts[3];
        available = parts[4].equals("1") || parts[4].toLowerCase().equals("true");
        state = new State(Long.parseLong(parts[5]));
    }

    public void show(float x, float y, float w, float h, Theme theme){
        state.show(x, y, w/2, theme.getOn(), theme.getOff());
        textAlign(CENTER, CENTER);
        float tSize = w/2/(""+damage).length();
        textSize(tSize);
        fill(typeToTint());
        rect(x+w/2,y,w/2,w/2);
        fill(0);
        text(""+damage, x+3*w/4, y+h/5-tSize/5);
        textAlign(CENTER, BOTTOM);
        fill(theme.getOff());
        textSize(w/10);
        text(name, x+w/2, y+3*w/4);
        textAlign(LEFT, TOP);
        textSize(w/15);
        text(flavor, x, y+3*w/4, w, y+5*h/8);

    }

    public long getEncoded(){
        return state.getEncoded();
    }

    private color typeToTint(){
        switch(type){
            case 'a':
                return color(255,255,150);
            case 'e':
                return color(50,150,50);
            case 'f':
                return color(255,100,100);
            case 'w':
                return color(150,150,255);
        }
        return color(200);
    }
}
