abstract class Screen {
    int wid;
    int hei;
    float margin;
    float gameWidth;
    
    public Screen(int width_, int height_){
        wid = width_;
        hei = height_;
        margin = min(wid, hei/2)/8;
        gameWidth = margin*6;
    }
}
