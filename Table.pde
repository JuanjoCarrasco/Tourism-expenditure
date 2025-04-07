//Loads data from .txt format files.
class Table {
  //Variable declaration.
  float[][] mat2;
  int Ncolumns;
  int Nrows;
  float[] f2;
  float[] f;
  float[] MaxMin;

  Table(String file) {

    //Each row in the file is saved in the rows vector as a text string.
    String[] rows=loadStrings(file); 
    
    //Number of rows.
    Nrows=rows.length;
   
    //Number of columns
    f2=float(split(rows[0], '\t')); 
    Ncolumns=f2.length;    
    
    //Data matrix
    float[][] mat=new float[Ncolumns][Nrows];
    
    for (int ind1=0; ind1<Nrows; ind1++) {      
      f=float(split(rows[ind1], '\t')); 

      for (int ind2=0; ind2<Ncolumns; ind2++) {        
        mat[ind2][ind1]=f[ind2];        
      }
    }
    //Local to global.
    mat2=mat;       
    
  }

  //Access to data.  
  //Get the number of rows.
  int getNrows() {
    return Nrows;
  }

  //Get the number of colums  
  int getNcolumns() {
    return Ncolumns;
  }  

  //Get data from matrix
  float getData(int col, int row) {
    return mat2[col][row];
  }

  //Get the max and min values of a column.  
  //Accessing these functions inside a loop slows down the program significantly.
  //Access them only once and save the result in a new variable.  
  float getMaxC(int col) {

    float[] x=new float[Nrows-1];
    for (int row = 1; row < Nrows; row++) {
      x[row-1] = mat2[col][row];
    }      
    float maxx=max(x);   
    return  maxx;
  }

  float getMinC(int col) {

    float[] x=new float[Nrows-1];
    for (int row = 1; row < Nrows; row++) {
      x[row-1] = mat2[col][row];
    }
    float minx=min(x);    
    return minx;
  }

  //Get the max and min values of a row. 
  float getMaxF(int row) {

    float[] x=new float[Ncolumns];    
    for (int col = 0; col < Ncolumns; col++) {
      x[col] = mat2[col][row];
    }      
    float maxx=max(x);   
    return  maxx;
  }

  float getMinF(int row) {

    float[] x=new float[Ncolumns];   
    for (int col = 0; col < Ncolumns; col++) {
      x[col] = mat2[col][row];     
    }
    float minx=min(x);    
    return minx;
  }

  //Get the max and min values of the data matrix.
  float getMax() {

    float[] x=new float[Nrows-1];
    float[] vmaxx=new float[Ncolumns];   

    for (int col=0; col<Ncolumns; col++) {
      for (int row = 1; row < Nrows; row++) {        
        x[row-1] = mat2[col][row];
      }  
      float maxx=max(x);
      vmaxx[col]=maxx;
    }

    float Max=max(vmaxx);   
    return  Max;
  }

  float getMin() {

    float[] x=new float[Nrows-1];
    float[] vminx=new float[Ncolumns]; 

    for (int col=0; col<Ncolumns; col++) {
      for (int row = 1; row < Nrows; row++) {        
        x[row-1] = mat2[col][row];
      }  
      float minx=min(x);
      vminx[col]=minx;
    }

    float Min=min(vminx);    
    return  Min;
  }
} //end class Table

