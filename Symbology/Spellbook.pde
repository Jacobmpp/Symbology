import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files

public class ReadFile {
  public static void main(String[] args) {
    
  }
}

class Spellbook{
    Spell spells[];
    boolean avalable[];
    int index = 0;
    
    Spellbook(String filename){
        loadSpells(filename);
    }
    
    private void loadSpells(String filename){
        try {
            File fp = new File(filename);
            Scanner s = new Scanner(fp);
            spells = new Spell[parseInt(s.nextLine())];
            int i = 0;
            while (s.hasNextLine()) {
                spells[i++]=new Spell(s.nextLine());
            }
            s.close();
        } catch (FileNotFoundException e) {
            System.out.println("Spells file not found!"); // Display to screen
            e.printStackTrace();
        }
    }
    
    public void show(int index, float x, float y, float w, float h){
        spells[index].show(x,y,w,h);
    }
}
