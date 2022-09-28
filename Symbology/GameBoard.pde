class GameBoard{
    private State state;
    private int lastSize = 0;
    private PImage board, original; //(Processing required)

    // Constructor
    GameBoard(State state_){
        state = state_;
    }

    // State Functions
    public void click(int x, int y){
        state.click(x, y);
    }
    public int getSize(){
        return state.getSize();
    }

    // Load Images (Processing required)
    private void loadImages(String filename){
        original = loadImage(filename+".board.png");
        board = original.get(((7-state.getSize())/2)*16,((7-state.getSize())/2)*16,16*state.getSize(),16*state.getSize());
        board.mask(masks[size-3]);
        board.resize(gWidth,gWidth);
    }

    // Show (Processing required)
    public void show(float x, float y, float gWidth, color on, color off, color stroke, float strokeWeight){
        int size = state.getSize();
        if(size<1)return;
        if(size!=lastSize){
            board = original.get(((7-state.getSize())/2)*16,((7-state.getSize())/2)*16,16*state.getSize(),16*state.getSize());
            board.mask(masks[size-3]);
            board.resize(gWidth,gWidth);
            lastSize = size;
        }
        state.show(x, y, gWidth, on, off, stroke, strokeWeight);
        image(board, x, y);
    }
}
