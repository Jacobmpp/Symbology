class State{
    boolean[][] subState;
    boolean[][] topState;
    long encodedTopState;
    int size;
    
    // Constructors
    State(boolean[][] state){
        size = state.length;
        subState = state;
        calc();
    }
    State(long state){
        convert(state);
    }
    State(int size_){
        size = size_;
        subState = new boolean[size][size];
        topState = new boolean[size][size];
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                subState[i][j] = false;
            }
        }
        calc();
    }
    State(){ // This is weird, make sure it works
        this((long)random(1<<3,1<<54) + 3); 
    }

    // Cell Math
    public void click(int x, int y){
        subState[x][y] = !subState[x][y];
        calc();
    }
    public void calc(){
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                sum(i, j);
            }
        }
        encodedTopState = convert(topState);
    }
    private void sum(int x, int y){
        boolean out = true;
        if(x>0&&subState[x-1][y])out=!out;
        if(y>0&&subState[x][y-1])out=!out;
        if(x<size-1&&subState[x+1][y])out=!out;
        if(y<size-1&&subState[x][y+1])out=!out;
        topState[x][y] = out;
    }

    // Resizing
    public int getSize(){
        return size;
    }
    private boolean[][] resize(boolean[][] board, int newSize){
        if(board.length == newSize)return board;
        boolean[][] out = new boolean[newSize][newSize];
        int offset = abs(newSize-board.length)/2 + (newSize + ((0<(board.length - newSize))?1:0))%2;
        boolean bigger = newSize > board.length;
        for(int i = 0; i < min(newSize, board.length); i++){
            for(int j = 0; j < min(newSize, board.length); j++){
                if(bigger){
                    out[i+offset][j+offset] = board[i][j];
                } else {
                    out[i][j] = board[i+offset][j+offset];
                }
            }
        }
        return out;
    }
    public boolean resize(int newSize){
        if(newSize<3||newSize>7)return false;
        subState = resize(subState, newSize);
        topState = resize(topState, newSize);
        size = newSize;
        return true;
    }

    // Encoding
    public long getEncoded(){
        return encodedTopState;
    }
    public long convert(boolean[][] state){
        long out = 0;
        for(int i = 0; i < size*size; i++){
            out<<=1;
            out+=(state[i%size][i/size])?1:0;
        }
        out<<=3;
        out+=size;
        return out;
    }
    public boolean[][] convert(long in){
        int s = (int)in%8;
        boolean out[][] = new boolean[s][s];
        in>>=3;
        for(int i = s*s-1; i >= 0; i--){
        out[i%s][i/s] = in%2==1;
        in>>=1;
        }
        return out;
    }

    // Show (Processing required)
    public void show(float x, float y, float gWidth, color on, color off, color stroke, float strokeWeight){
        if(size<1)return;
        strokeWeight(strokeWeight);
        stroke(stroke);
        fill(on);
        for(int i = 0; i < size; i++)
          for(int j = 0; j < size; j++)
            if(topState[i][j])
              rect(x+i*gWidth/size, y+j*gWidth/size, gWidth/size, gWidth/size);
        fill(off);
        for(int i = 0; i < size; i++)
          for(int j = 0; j < size; j++)
            if(!topState[i][j])
              rect(x+i*gWidth/size, y+j*gWidth/size, gWidth/size, gWidth/size);
    }
    public void show(float x, float y, float gWidth, color on, color off, color stroke, float strokeWeight, boolean debug){
        show(x, y, gWidth, on, off, stroke, strokeWeight);
        if(!debug)
        fill(color(255,0,0));
        for(int i = 0; i < size; i++)
          for(int j = 0; j < size; j++)
            if(!topState[i][j])
              ellipse(x+(i+.5)*gWidth/size, y+(j+.5)*gWidth/size, gWidth/size/2, gWidth/size/2);
    }
 }
