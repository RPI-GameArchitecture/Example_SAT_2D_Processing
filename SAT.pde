Shape s0,s1,s2;
void setup()
{
  size (800,600);
  
  s1 = new Shape();
  s1.vertices.add (new PVector(90,120,0));
  s1.vertices.add (new PVector(120,100,0));
  s1.vertices.add (new PVector(115,140,0));
  s1.vertices.add (new PVector(95,130,0));
  s1.clr = color(255,128,0);
  
  s0=new Shape();
  s0.vertices.add (new PVector (-15,-10,0));
  s0.vertices.add (new PVector (0,-30,0));
  s0.vertices.add (new PVector (30,0,0));
  s0.vertices.add (new PVector (10,10,0));  
  s0.clr = color (0,128,255);
  
  s2=new Shape();
  s2.makeTranslation(s0,100,100);
  s2.clr=color(0,128,255);  
}

void draw()
{    
  background(255);
  if (mousePressed)
    s2.makeTranslation(s0,mouseX,mouseY);
  
  s1.draw();
  s2.draw();
  println(SAT_Test());
}


boolean SAT_Test()
{
  // make a list of axes. these are the normals.
  // on each axis, project the two shapes onto that axis
  // project each vertex onto the axis
  // find the extents of each shape by min/max dot product
  // and then find overlap the same way (?)
  // yes, the projection of the shape onto the axis results in a min and max dot product value.  compare those. 
  ArrayList<PVector> axes;
       int i;

    axes = new ArrayList<PVector>();
     for (i=0;i<s1.vertices.size()-1;i++)
     {
       axes.add(s1.getEdgeNormal(i,i+1));
     }
       axes.add(s1.getEdgeNormal(i,0));
    
     for (i=0;i<s2.vertices.size()-1;i++)
     {
       axes.add(s2.getEdgeNormal(i,i+1));
     }
       axes.add(s2.getEdgeNormal(i,0));
       
    for (i=0;i<axes.size();i++)
    {
        PVector a=axes.get(i);
        // get magnitude of projection of each vertex of shape 1 onto the axis 
        float min1, min2, max1, max2;
        max1=0;
        max2=0;
        min1=s1.vertices.get(0).dot(a);
        min2=s2.vertices.get(0).dot(a);

        for (int j=0;j<s1.vertices.size();j++)
        {
           PVector vert = s1.vertices.get(j);
           float p = vert.dot(a);
           if (p<min1) min1=p;
           if (p>max1) max1=p;
        }
        
        for (int j=0;j<s2.vertices.size();j++)
        {
           PVector vert = s2.vertices.get(j);
           float p = vert.dot(a);
           if (p<min2) min2=p;
           if (p>max2) max2=p;          
        }
        
        // check for a gap
        
        if (max1>max2 && min1>max2)
        {
           return false; 
        }
        if (max2>max1 && min2>max1)
        {
           return false;
        }
    }
    return true;
}
