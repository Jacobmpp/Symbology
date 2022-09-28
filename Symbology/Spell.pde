class Spell{
    int damage;
    char type;
    String flavor;
    boolean discoverable;
    State state;
    
    Spell(String encoded){
        String parts[] = encoded.split(",");
        damage = parseInt(parts[0]);
        type = parts[1].charAt(0);
        flavor = parts[2];
        discoverable = parts[3].equals("1") || parts[3].toLowerCase().equals("true");
        state = new State(Long.parseLong(parts[4]));
    }

    public void show(float x, float y, float w, float h){
        //TODO
    }
}
