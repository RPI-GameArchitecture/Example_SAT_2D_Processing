class Shape {
  ArrayList<PVector> vertices;
  color clr;
  Shape () 
  {
     vertices = new ArrayList<PVector>();
     clr=0;
  }
  
  PVector getEdgeNormal (int v1, int v2)
  {
    PVector p1,p2;
    p1=vertices.get(v1);
    p2=vertices.get(v2);
    PVector d=p1.copy();
    d.sub(p2);
    PVector n=new PVector (-d.y, d.x);
    return (n);
  }
  
  void makeTranslation(Shape s,int x, int y)
  {
    vertices = new ArrayList<PVector>();
    for (int i=0;i<s.vertices.size();i++)
    {
       PVector v0 = s.vertices.get(i);
       PVector v=new PVector(v0.x + x, v0.y + y);
       vertices.add(v);
    }
  }
  
  void drawEdgeNormal(int v1, int v2)
  {
    PVector p1,p2;
    p1=vertices.get(v1);
    p2=vertices.get(v2);
    
    PVector n=getEdgeNormal(v1,v2);
    n.normalize();
    n.mult(10);
    PVector midPoint = p1.copy();
    midPoint.add(p2);
    midPoint.mult(.5);
    
    line (midPoint.x, midPoint.y, midPoint.x + n.x, midPoint.y + n.y);
  }
  
  void drawEdge(int v1, int v2)
  {
    
    PVector p1,p2;
    p1=vertices.get(v1);
    p2=vertices.get(v2);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  void draw()
  {
    stroke(clr);
    if (vertices.size() >0)
    {
     int i;
     for (i=0;i<vertices.size()-1;i++)
     {
       drawEdge(i,i+1);
       PVector n=getEdgeNormal(i,i+1);
       drawEdgeNormal(i,i+1);
     }
     drawEdge(i,0);
     drawEdgeNormal(i,0);

    }
  }
}
