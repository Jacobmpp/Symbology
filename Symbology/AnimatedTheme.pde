class AnimatedTheme extends Theme {
    int speed;

    public AnimatedTheme(int on_, int off_, int speed_){
        super(on_, off_);
        speed=speed_;
    }

    @Override
    public color getOn(){
        colorMode(HSB,255);
        on = color((hue(on)+speed)%256, saturation(on), brightness(on));
        colorMode(RGB,255);
        return on;
    }
}