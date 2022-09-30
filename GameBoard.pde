class GameBoard{
    private int scaleFactor = 20;
    private State state;
    private int lastSize = 0;
    private PImage board, original; 
    private PVector topCorner = null;
    private PVector dimensions = null;

    // Constructor
    GameBoard(State state_, int gWidth){
        state = state_;
        loadImages("assets/brick.board.png", gWidth);
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
    public int getSize(){
        return state.getSize();
    }
    public State getState(){
        return state;
    }
    public boolean resize(int newSize){
      return state.resize(newSize);
    }

    // Load Images
    private void loadImages(String filename, int gWidth){
        original = loadImage(filename);
        board = original.get(((7-state.getSize())/2)*16*scaleFactor,((7-state.getSize())/2)*16*scaleFactor,16*state.getSize()*scaleFactor,16*state.getSize()*scaleFactor);
        board.resize(gWidth,gWidth);
    }

    // Show
    public void show(float x, float y, float gWidth, color on, color off, boolean debug){
        int size = state.getSize();
        if(topCorner==null)topCorner=new PVector(x, y);
        if(dimensions==null)dimensions=new PVector(gWidth, gWidth);
        if(size<1)return;
            if(size!=lastSize){
                board = original.get(((7-state.getSize())/2)*16*scaleFactor, ((7-state.getSize())/2)*16*scaleFactor, 16*state.getSize()*scaleFactor, 16*state.getSize()*scaleFactor);
                board.resize((int)gWidth,(int)gWidth);
                lastSize = size;
            }
        state.show(x, y, gWidth, on, off, debug);
        image(board, x, y);
    }
}
