class Theme{
    protected color on;
    protected color off;
    protected color background;
    protected PImage backgroundImage;

    Theme(color on_, color off_, color background_, String backgroundImageFilename, int wid, int hei){
        on = on_;
        off = off_;
        background = background_;
        backgroundImage = loadImage("assets/backgrounds/"+backgroundImageFilename+".background.png");
        backgroundImage.resize(wid,hei);
    }

    public color getOn(){
        return on;
    }
    public color getOff(){
        return off;
    }
    public color getBackground(){
        return background;
    }
    public PImage getBackgroundImage(){
        return backgroundImage;
    }

    public void update(){}
}
