class GameBoard{
    private int scaleFactor = 20;
    private State state;
    private int lastSize = 0;
    private PImage board, original, boarder; 
    private PVector topCorner = null;
    private PVector dimensions = null;
    public PVector center = null;

    // Constructor
    GameBoard(State state_, int gWidth){
        state = state_;
        loadImages("assets/brick.board.png", gWidth);
        boarder = loadImage("assets/boarder.board.png");
        boarder.resize((int)(gWidth*1.2), (int)(gWidth*1.2));
    }
    GameBoard(int gWidth){
        this(new State(3), gWidth);
    }

    // State Functions
    public void click(int mx, int my){
        int size = getState().getSize();
        int x = floor((mx-topCorner.x)/(dimensions.x/size));
        int y = floor((my-topCorner.y)/(dimensions.y/size));
        if(!(x>=size||x<0 || y>=size||y<0)){
            state.click(x,y);
        }
    }
    public void scramble(){
        state.scramble();
    }
    public int getSize(){
        return state.getSize();
    }
    public State getState(){
        return state;
    }
    public boolean resize(int newSize){
        return state.resize(newSize);
    }
    public boolean onBoard(int mx, int my){
        int x = floor((mx-topCorner.x));
        int y = floor((my-topCorner.y));
        return !(x>=dimensions.x||x<0 || y>=dimensions.y||y<0);
    }
    public long getEncoded(){
        return state.getEncoded();
    }

    // Load Images
    private void loadImages(String filename, int gWidth){
        original = loadImage(filename);
        board = original.get(((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor,((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor,16*state.getSize()*scaleFactor,16*state.getSize()*scaleFactor);
        board.resize(gWidth, gWidth);
    }

    // Show
    public void show(float x, float y, float gWidth, color on, color off, boolean debug){
        int size = state.getSize();
        if(topCorner==null)topCorner=new PVector(x, y);
        if(dimensions==null)dimensions=new PVector(gWidth, gWidth);
        if(center==null)center=new PVector(x+gWidth/2, y+gWidth/2);
        if(size<1)return;
            if(size!=lastSize){
                board = original.get(((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor, ((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor, 16*state.getSize()*scaleFactor, 16*state.getSize()*scaleFactor);
                lastSize = size;
                board.resize((int)gWidth, (int)gWidth);
            }
        tint(red(on), green(on), blue(on));
        image(boarder, x-gWidth*0.1, y-gWidth*0.1, gWidth*1.2, gWidth*1.2);
        tint(255,255,255);
        state.show(x, y, gWidth, on, off, debug);
        image(board, x, y, gWidth, gWidth);
    }
}
