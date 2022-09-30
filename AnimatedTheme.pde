class AnimatedTheme extends Theme {
    int speed;

    public AnimatedTheme(int on_, int off_, int background_, int speed_){
        super(on_, off_, background_);
        speed=speed_;
    }

    @Override
    public color getOn(){
        colorMode(HSB,255);
        on = color((hue(on)+speed)%256, saturation(on), brightness(on));
        colorMode(RGB,255);
        return on;
    }
    @Override
    public color getOff(){
        colorMode(HSB,255);
        off = color((hue(on)+speed)%256, saturation(off), brightness(off));
        colorMode(RGB,255);
        return off;
    }
    @Override
    public color getBackground(){
        colorMode(HSB,255);
        background = color((hue(on)+speed)%256, saturation(background), brightness(background));
        colorMode(RGB,255);
        return background;
    }
}
