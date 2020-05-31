  ///////////@@@@@  DFS  @@@@@//////////////////////@@@@@  DFS  @@@@@//////////////////////@@@@@  DFS  @@@@@///////////
  class Point { 
    int x,y; 
    public Point(int x, int y) { 
        this.x = x; 
        this.y = y; 
    } 
  }; 
  class queueNode{ 
    Point pt;
    int dist; 
    public queueNode(Point pt, int dist) 
    { 
        this.pt = pt; 
        this.dist = dist; 
    } 
  }; 
  boolean isValid(int row, int col){ 
    return (row >= 0) && (row < boardSizeX) && 
           (col >= 0) && (col < boardSizeY); 
  } 
  int BFS(Tile mat[][], Point src, Point dest)  { 
   int rowNum[] = {-1, 0, 0, 1}; 
   int colNum[] = {0, -1, 1, 0}; 
   
    boolean [][]visited = new boolean[boardSizeX][boardSizeY]; 
    visited[src.x][src.y] = true; 
    Queue<queueNode> q = new LinkedList(); 
    queueNode s = new queueNode(src, 0); 
    q.add(s); // Enqueue source cell 
    while (!q.isEmpty()){ 
        queueNode curr = q.peek(); 
        Point pt = curr.pt; 
        if (pt.x == dest.x && pt.y == dest.y) 
            return curr.dist; 
        q.remove(); 
        for (int i = 0; i < 4; i++){ 
            int row = pt.x + rowNum[i]; 
            int col = pt.y + colNum[i]; 
            if (isValid(row, col) && mat[row][col].type == Type.Empty && !visited[row][col])  { 
                visited[row][col] = true; 
                queueNode Adjcell = new queueNode(new Point(row, col), curr.dist + 1 ); 
                q.add(Adjcell); 
            } 
        } 
    } 
    return -1; 
  } 
  ///////////@@@@@  DFS  @@@@@//////////////////////@@@@@  DFS  @@@@@//////////////////////@@@@@  DFS  @@@@@///////////
