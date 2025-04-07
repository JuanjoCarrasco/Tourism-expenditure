//Displays on-screen help by highlighting controls.
void Help()
{  
  fill(#F9FF5A, 220);
  noStroke(); 
  //Help year selection.
  if (t2<=width-300 )
  {
    t2+=tInc2;
  }
  else 
  {
    t2=0;
  } 
  ellipse(220+t2, 40, 70, 70);  

  //Help country selection.
  if (t3<=height-220 )
  {
    t3+=tInc3;
  }
  else 
  {
    t3=0;
  }  
  rectMode(CORNER);
  rect(10, 122+t3, 145, 24);

  //Help size and transparency selection.
  if (t4<=270 )
  {
    t4+=tInc4;
  }
  else 
  {
    t4=0;
  }    
  ellipse(220+t4, height-45, 70, 70);  

  fill(#0026B9);
  textFont(font3);
  text("Select countries", 135, 100); 
  text("Select year or play animation", width-300, 100);
  text("Set flag size and transparency", 670, height-20);  
  text("Cursor over the flag + left mouse button = label on", width/2+50, height/2-200);
  text("Cursor over the flag + right mouse button = label off", width/2+50, height/2-150);
}

