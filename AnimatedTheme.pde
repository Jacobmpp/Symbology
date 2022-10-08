class AnimatedTheme extends Theme {
    float speed;
    float hue;

    public AnimatedTheme(int on_, int off_, int background_, String backgroundImageFilename, float speed_){
        super(on_, off_, background_, backgroundImageFilename);
        speed=speed_;
        hue = hue(on);
    }

    @Override
    public void update(){
        hue = (hue+speed);
        if(hue>256)hue-=256;
    }
    @Override
    public color getOn(){
        colorMode(HSB,255);
        on = color(floor(hue), saturation(on), brightness(on));
        colorMode(RGB,255);
        return on;
    }
    @Override
    public color getOff(){
        colorMode(HSB,255);
        off = color(floor(hue), saturation(off), brightness(off));
        colorMode(RGB,255);
        return off;
    }
    @Override
    public color getBackground(){
        colorMode(HSB,255);
        background = color(floor(hue), saturation(background), brightness(background));
        colorMode(RGB,255);
        return background;
    }
}
