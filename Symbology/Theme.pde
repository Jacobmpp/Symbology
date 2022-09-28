class Theme{
    protected color on;
    protected color off;

    Theme(color on_, color off_){
        on = on_;
        off = off_;
    }

    public color getOn(){
        return on;
    }
    public color getOff(){
        return off;
    }
}
