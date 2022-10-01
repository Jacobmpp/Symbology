abstract class Screen {
    int wid;
    int hei;
    float margin;
    float gameWidth;
    
    public Screen(int width_, int height_){
        wid = width_;
        hei = height_;
        margin = min(width_, 3*height_/4)/8;
        gameWidth = min(width_, 3*height_/4)-margin*2;;
    }
}
