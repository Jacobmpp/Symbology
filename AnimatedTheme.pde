class AnimatedTheme extends Theme {
    float speed;
    float hue;

    public AnimatedTheme(int on_, int off_, int background_, String backgroundImageFilename, float speed_, int wid, int hei){
        super(on_, off_, background_, backgroundImageFilename, wid, hei);
        speed=speed_;
        hue = hue(on);
    }

    @Override
    public void update(){ // changes the hue over time
        hue = (hue+speed);
        if(hue>256)hue-=256;
    }
    @Override
    public color getOn(){
        colorMode(HSB,255);
        on = color(floor(hue), saturation(on), brightness(on)); // recolor based on hue
        colorMode(RGB,255);
        return on;
    }
    @Override
    public color getOff(){
        colorMode(HSB,255);
        off = color(floor(hue), saturation(off), brightness(off)); // recolor based on hue
        colorMode(RGB,255);
        return off;
    }
    @Override
    public color getBackground(){
        colorMode(HSB,255);
        background = color(floor(hue), saturation(background), brightness(background)); // recolor based on hue
        colorMode(RGB,255);
        return background;
    }
}
