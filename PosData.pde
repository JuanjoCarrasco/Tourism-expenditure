//Compute the position of the data.
void PosData(int j, int i)
{
  //Only selected countries are shown.
  if (Gcheckbox2[i-1].getItem(0).getState()==true)
  {
    //Starting position.
    Xmap1= map(ExpTable.getData(j, i), +
      ExpendMin, ExpendMax, 230, width-100);        
    Ymap1= map(constrain(ExpChangeTable.getData(j, i), -120, 120), +
      -120, 120, height-120, 140);  
    //Final position
    Xmap2= map(ExpTable.getData(j+1, i), +
      ExpendMin, ExpendMax, 230, width-100);        
    Ymap2= map(constrain(ExpChangeTable.getData(j+1, i), -120, 120), +
      -120, 120, height-120, 140);
   
    //Interpolation (auto or manual)
    if (checkbox.getState(0)==true) {
      interpx=lerp(Xmap1, Xmap2, t-j);
      interpy=lerp(Ymap1, Ymap2, t-j);
      Change = form1.format(lerp(ExpChangeTable.getData(j, i), +
        ExpChangeTable.getData(j+1, i), t-j));
      Expend = form1.format(lerp(ExpTable.getData(j, i), +
        ExpTable.getData(j+1, i), t-j));
    }
    else {  
      interpx=lerp(Xmap1, Xmap2, sliderValue-j);
      interpy=lerp(Ymap1, Ymap2, sliderValue-j);
      Change = form1.format(lerp(ExpChangeTable.getData(j, i), +
        ExpChangeTable.getData(j+1, i), sliderValue-j));
      Expend = form1.format(lerp(ExpTable.getData(j, i), +
        ExpTable.getData(j+1, i), sliderValue-j));
    }     

    //Show Flags
    tint(255, trans);
    image(GIcoFlags[i-1], interpx, interpy, size, size);

    //Tooltip
    if (sliderValue==Ncolumns-1)
    {  
      Year = form2.format(ExpTable.getData(j+1, 0));
    }
    else
    {      
      Year = form2.format(ExpTable.getData(j, 0));
    }    

    //Pressing the left mouse button and hovering over the flag
    //activates the label. Right-clicking deactivates it.
    if ((MouseClick == 1)&& (dist(interpx, interpy, mouseX, mouseY) < 15)) {
      TooltipAct[i-1]=true;
    }
    else if ((MouseClick == 0)&& (dist(interpx, interpy, mouseX, mouseY) < 15))
    {
      TooltipAct[i-1]=false;
    }      

    //Selected tags.
    if (TooltipAct[i-1]==true)
    { 
      PosTooltip();
      tooltip.setText("Country: " + Countries[i-1]+ "\n"+
        "Growth (%): " + Change + "\n" +
        "Expend. US$ M: " + Expend + "\n" +
        "Year: " +  Year );
      tooltip.draw(interpx, interpy);
    }
  }//Gcheckbox2[i-1]
}//PosData

