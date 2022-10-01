import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files
import java.util.Hashtable;

class Spellbook{
    private Hashtable <Long, Spell> spells = new Hashtable<Long, Spell>();
    private long spellsLookup[];
    boolean avalable[];
    int index = 0;
    
    Spellbook(String filename){
        loadSpells(filename);
    }
    
    private void loadSpells(String filename){
        try {
            String[] lines = loadStrings(filename);
            spellsLookup = new long[lines.length];
            for(int i=0; i<lines.length;i++) {
                Spell temp = new Spell(lines[i]);
                spells.put(temp.getEncoded(), temp);
                spellsLookup[i] = temp.getEncoded();
            }
        } catch (NullPointerException e) {
            System.out.println("Spells file not found!"); // Display to screen
            e.printStackTrace();
        }
    }
    
    public void show(int index, float x, float y, float w, float h){
        spells.get(spells.get(index)).show(x,y,w,h);
    }

    public Spell getSpell(long encodedTopState){
        return spells.get(encodedTopState);
    }
}
