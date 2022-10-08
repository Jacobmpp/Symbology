class Spell{
    String name;
    int damage;
    char type;
    String flavor;
    boolean discoverable;
    State state;
    
    Spell(String encoded){
        String parts[] = encoded.split(",");
        name = parts[0];
        damage = parseInt(parts[1]);
        type = parts[2].charAt(0);
        flavor = parts[3];
        discoverable = parts[4].equals("1") || parts[4].toLowerCase().equals("true");
        state = new State(Long.parseLong(parts[5]));
        
        
    }

    public void show(float x, float y, float w, float h){
        //TODO
    }

    public long getEncoded(){
        return state.getEncoded();
    }
}
