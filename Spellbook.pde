import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files
import java.util.Hashtable;

class Spellbook{
    private Hashtable <Long, Spell> spells = new Hashtable<Long, Spell>();
    private long spellsLookup[];
    private PImage background;
    private float x, y, w, h;

    public boolean visible = false, toggleable = false;
    public int visibleIndex = 0;
    int spellCount = 0;

    Spellbook(String spellFile, String bgFile){
        loadSpells(spellFile);
        background = loadImage("assets/"+ bgFile + ".spellbook.png");
    }

    private void loadSpells(String filename){
        try {
            String[] lines = loadStrings(filename);
            spellsLookup = new long[lines.length];
            for(int i=0; i<lines.length;i++) {
                if(lines[i].split(";").length>5){
                    Spell temp = new Spell(lines[i]);
                    spells.put(temp.getEncoded(), temp);
                    spellsLookup[spellCount++] = temp.getEncoded();
                }
            }
        } catch (NullPointerException e) {
            println("Spells file not found!"); // Display to screen
            e.printStackTrace();
        }
    }

    public void click(int mX, int mY, BattleScreen screen){
        int attempts = 0;
        do {
            if(pow(x+3*w/16-mX,2)+pow(y+7*h/8-mY,2)<pow(screen.margin,2)){
                visibleIndex = ((visibleIndex - 1)+spellCount)%spellCount;
            } else if(pow(x+13*w/16-mX,2)+pow(y+7*h/8-mY,2)<pow(screen.margin,2)){
                visibleIndex = (visibleIndex + 1)%spellCount;
            }
        } while(!getSpellIndexed(visibleIndex).available && attempts++<spellCount-1);
    }

    public void show(float deployment, float w_, float h_, BattleScreen screen, Theme theme){
        w = w_;
        h = h_;
        if(toggleable){
            if(visible){
                x = map(constrain(deployment, -1, 0), -1, 0, width-screen.margin/2, width/2-w/2);
            } else {
                x = map(constrain(deployment,  0, 1),  0, 1, width-screen.margin/2, width/2-w/2);
            }
            if(deployment>1){
                visible=true;
            } else if(deployment<-1){
                visible=false;
            }
        } else if(visible){
            x = width/2-w/2;
        } else {
            x = width-screen.margin/2;
        }
        y = height/2-h/2;
        tint(theme.getOn());
        image(background, x, y, w, h);
        tint(255);
        fill(theme.getOff());
        triangle(x+w/8,y+7*h/8, x+w/4,y+13*h/16, x+w/4,y+15*h/16);
        triangle(x+7*w/8,y+7*h/8, x+3*w/4,y+13*h/16, x+3*w/4,y+15*h/16);
        if(x+screen.margin/2<width)spells.get(spellsLookup[visibleIndex]).show(x+screen.margin/2,y+screen.margin/2,w-screen.margin,h-screen.margin, theme);
    }

    public Spell getSpell(long encodedTopState){
        return spells.get(encodedTopState);
    }

    public Spell getSpellIndexed(int spellNum){
        return spells.get(spellsLookup[spellNum]);    
    }

    public int getSpellCount(){
        return spellCount;
    }

    public int someSpellsUnavailable(){
        int count = 0;
        for(int i=0;i<getSpellCount();i++){
            if(!getSpellIndexed(i).available)count++;
        }
        return count;
    }

    public String getAvailableSpells(){
        String out = "";
        for(int i = 0; i < spellCount; i++){
            Spell temp = getSpellIndexed(i);
            if(temp.available)out+=temp.getStateEncoded()+",";
        }
        out = out.substring(0,max(out.length()-1,0));
        return out;
    }

    public void updateAvailableSpells(String encodedList){
        String stateCodes[] = encodedList.split(",");
        for(int i=0;i<spellCount;i++){
            getSpellIndexed(i).available = false;
        }
        for(String s : stateCodes){
            long temp = new State().StringToLong(s);
            if(spells.containsKey(temp))
                spells.get(temp).available = true;
        }
    }
}
