import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files

class Spellbook{
    Spell spells[];
    boolean avalable[];
    int index = 0;
    
    Spellbook(String filename){
        loadSpells(filename);
    }
    
    private void loadSpells(String filename){
        try {
            String[] lines = loadStrings(filename);
            spells = new Spell[lines.length];
            for(int i=0; i<lines.length;i++) {
                spells[i-1]=new Spell(lines[i]);
            }
        } catch (NullPointerException e) {
            System.out.println("Spells file not found!"); // Display to screen
            e.printStackTrace();
        }
    }
    
    public void show(int index, float x, float y, float w, float h){
        spells[index].show(x,y,w,h);
    }
}
