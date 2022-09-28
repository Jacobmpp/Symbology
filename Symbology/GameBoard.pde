class GameBoard{
    private State state;
    private int lastSize = 0;
    private PImage board, original; //(Processing required)

    // Constructor
    GameBoard(State state_, int gWidth){
        state = state_;
        loadImages("assets/brick", gWidth);
    }
    GameBoard(int gWidth){
      this(new State(3), gWidth);
    }

    // State Functions
    public void click(int x, int y){
        state.click(x, y);
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

    // Load Images (Processing required)
    private void loadImages(String filename, int gWidth){
        original = loadImage(filename+".board.png");
        board = original.get(((7-state.getSize())/2)*16,((7-state.getSize())/2)*16,16*state.getSize(),16*state.getSize());
        board.resize(gWidth,gWidth);
    }

    // Show (Processing required)
    public void show(float x, float y, int gWidth, color on, color off, color stroke, float strokeWeight){
        int size = state.getSize();
        if(size<1)return;
        if(size!=lastSize){
            board = original.get(((7-state.getSize())/2)*16,((7-state.getSize())/2)*16,16*state.getSize(),16*state.getSize());
            board.resize(gWidth,gWidth);
            lastSize = size;
        }
        state.show(x, y, gWidth, on, off, stroke, strokeWeight);
        image(board, x, y);
    }
}
