class Theme{
    protected color on;
    protected color off;
    protected color background;

    Theme(color on_, color off_, color background_){
        on = on_;
        off = off_;
        background = background_;
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
}
