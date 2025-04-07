import java.text.DecimalFormat;
import controlP5.*;
import org.gicentre.utils.move.Ease;
import org.gicentre.utils.gui.Tooltip;
import org.gicentre.utils.spatial.Direction;

//Variable declaration.
Table ExpChangeTable;
Table ExpTable;
int Nrows, Nrows2, Ncolumns, Ncolumns2;
float  ChangeMin, ChangeMax, ExpendMin, ExpendMax;
float Xmap1, Ymap1, Xmap2, Ymap2, interpx, interpy;
float t=0, tInc = 0.01, t2=170, tInc2 = 10, t3=170, tInc3 = 5.6, t4=170, tInc4 = 2.1;
float size, trans;
float sliderValue=0;
CheckBox checkbox, checkbox3;
CheckBox[] Gcheckbox2;
ControlP5 cp5;
Slider SliderValue, SliderValue2, SliderValue3, SliderValue4;
PImage[] GIcoFlags;
String[] years;
DecimalFormat form1 = new DecimalFormat("#.#");
DecimalFormat form2 = new DecimalFormat("#");
float[] Yaxis=new float[11]; 
float[] Xaxis=new float[21]; 
PFont font1, font2, font3, font4;

String[]  Countries = {
  "Austria", "Belgium", "Bulgaria", "Cyprus", "Czech Republic", 
  "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", 
  "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", 
  "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", 
  "Sweden", "UK"
};

Boolean[] TooltipAct = {
  false, false, false, false, false, false, false, false, 
  false, false, false, false, false, false, false, false, false, false, false, false, false, false, 
  false, false, false, false, false
};

private Tooltip tooltip;
float interpxExt;
float interpyExt;
String Country;
String  Change;
String  Expend;
String Year;
int MouseClick=0;
boolean HPressed =false;

//Initial app setup
void setup() {  

  //Screen size
  size(1600, 950);
  //Allow screen resize
  frame.setResizable(false);
  //Frame rate per second
  frameRate(30);
  //Smooth edges
  smooth();  
  //Load data
  ExpChangeTable = new Table("TourismExpChange.txt");
  ExpTable = new Table("TourismExpenditure.txt");

  //Get the number of rows  
  Nrows = ExpChangeTable.getNrows();
  //Get the number of colums  
  Ncolumns = ExpChangeTable.getNcolumns(); 
  //Max and min values for mapping
  ChangeMax=ExpChangeTable.getMax();  
  ChangeMin=ExpChangeTable.getMin(); 
  ExpendMax=ExpTable.getMax();  
  ExpendMin=ExpTable.getMin();  

  //Values ​​for the y-axis.
  for (int div = 0; div < 11; div++) { 
    Yaxis[div]=120-(((120-(-120))/10.0)*div);
  }

  //Values ​​for the x-axis.
  int div2=20;
  for (int div = 0; div < 21; div++) { 
    Xaxis[div2]=ExpendMax-(((ExpendMax-ExpendMin)/20.0)*div);
    div2--;
  }

  //Load text fonts.
  font1 = createFont("arial", 18);
  font2 = createFont("arial", 15);
  font3 = createFont("arial", 22);
  font4 = createFont("arial", 12);

  imageMode(CENTER);
  //Load flags.
  loadIcons();  
  //Interface configuration (slider, buttons, etc.)
  gui();   

  //Tags
  tooltip= new Tooltip(this, font2, 14, 180);
  color c1=color(#84DB73, 200);  
  tooltip.setTextColour(0);
  tooltip.setBorderColour(c1);
  tooltip.setBorderWidth(0);  
  tooltip.setBackgroundColour(c1);
  tooltip.setIsCurved(true);
  tooltip.showPointer(true);
  tooltip.setAnchor(Direction.SOUTH_WEST);
}

//Load flags.
void loadIcons()
{
  PImage[] iconsFlags = {
    loadImage("Austria.png"), loadImage("Belgium.png"), loadImage("Bulgaria.png"), 
    loadImage("Cyprus.png"), loadImage("Czech Republic.png"), loadImage("Denmark.png"), 
    loadImage("Estonia.png"), loadImage("Finland.png"), loadImage("France.png"), 
    loadImage("Germany.png"), loadImage("Greece.png"), loadImage("Hungary.png"), 
    loadImage("Ireland.png"), loadImage("Italy.png"), loadImage("Latvia.png"), 
    loadImage("Lithuania.png"), loadImage("Luxembourg.png"), loadImage("Malta.png"), 
    loadImage("Netherlands.png"), loadImage("Poland.png"), loadImage("Portugal.png"), 
    loadImage("Romania.png"), loadImage("Slovakia.png"), loadImage("Slovenia.png"), 
    loadImage("Spain.png"), loadImage("Sweden.png"), loadImage("UK.png")    
    };
    GIcoFlags = iconsFlags;
}

//Buttons
void gui() {

  cp5 = new ControlP5(this);

  //Checkbox to start animation
  PImage[] imgs = {
    loadImage("button_a.png"), loadImage("button_b.png"), loadImage("button_c.png")
    };    
    checkbox = cp5.addCheckBox("checkBox")
      .setPosition(width-250, 10)
        .setColorForeground(color(#017993))
          .setColorBackground(color(#003450))
            .setColorActive(color(#00CEFF))
              .setColorLabel(color(255))
                .setSize(40, 40)
                  .addItem("", 0)  
                    .setImages(imgs[2], imgs[1], imgs[1]);  

  //Icons for legend checkboxes
  PImage[] IcoFlagsB = {
    loadImage("AustriaIcob.png"), loadImage("BelgiumIcob.png"), loadImage("BulgariaIcob.png"), 
    loadImage("CyprusIcob.png"), loadImage("Czech RepublicIcob.png"), loadImage("DenmarkIcob.png"), 
    loadImage("EstoniaIcob.png"), loadImage("FinlandIcob.png"), loadImage("FranceIcob.png"), 
    loadImage("GermanyIcob.png"), loadImage("GreeceIcob.png"), loadImage("HungaryIcob.png"), 
    loadImage("IrelandIcob.png"), loadImage("ItalyIcob.png"), loadImage("LatviaIcob.png"), 
    loadImage("LithuaniaIcob.png"), loadImage("LuxembourgIcob.png"), loadImage("MaltaIcob.png"), 
    loadImage("NetherlandsIcob.png"), loadImage("PolandIcob.png"), loadImage("PortugalIcob.png"), 
    loadImage("RomaniaIcob.png"), loadImage("SlovakiaIcob.png"), loadImage("SloveniaIcob.png"), 
    loadImage("SpainIcob.png"), loadImage("SwedenIcob.png"), loadImage("UKIcob.png")
    };    

  PImage[] IcoFlagsC = {
    loadImage("AustriaIcoc.png"), loadImage("BelgiumIcoc.png"), loadImage("BulgariaIcoc.png"), 
    loadImage("CyprusIcoc.png"), loadImage("Czech RepublicIcoc.png"), loadImage("DenmarkIcoc.png"), 
    loadImage("EstoniaIcoc.png"), loadImage("FinlandIcoc.png"), loadImage("FranceIcoc.png"), 
    loadImage("GermanyIcoc.png"), loadImage("GreeceIcoc.png"), loadImage("HungaryIcoc.png"), 
    loadImage("IrelandIcoc.png"), loadImage("ItalyIcoc.png"), loadImage("LatviaIcoc.png"), 
    loadImage("LithuaniaIcoc.png"), loadImage("LuxembourgIcoc.png"), loadImage("MaltaIcoc.png"), 
    loadImage("NetherlandsIcoc.png"), loadImage("PolandIcoc.png"), loadImage("PortugalIcoc.png"), 
    loadImage("RomaniaIcoc.png"), loadImage("SlovakiaIcoc.png"), loadImage("SloveniaIcoc.png"), 
    loadImage("SpainIcoc.png"), loadImage("SwedenIcoc.png"), loadImage("UKIcoc.png")   
    };    

  CheckBox[] checkbox2 = new CheckBox[Nrows-1];

  for (int i=0; i<Nrows-1; i++) {     
    checkbox2[i] = cp5.addCheckBox("checkBox2_" + i)
      .setPosition(18, 125+(26*i)) 
        .setSize(23, 23)
          .setItemsPerRow(1)              
            .setSpacingRow(20)  
              .addItem(Countries[i], i)   
                .setImages(IcoFlagsC[i], IcoFlagsB[i], IcoFlagsB[i])
                  .activate(0);
  } 
  Gcheckbox2=checkbox2;

  //Checkbox for select all Countries.
  checkbox3 = cp5.addCheckBox("checkBox3")
    .setPosition(18, height-90)
      .setColorForeground(color(#017993))
        .setColorBackground(color(#003450))
          .setColorActive(color(#00CEFF))
            .setColorLabel(color(0))
              .setSize(22, 22)                               
                .addItem("All", 0)
                  .hideLabels() 
                    .activate(0);

  //Slider for year selection.
  SliderValue=cp5.addSlider("sliderValue")
    .setPosition(220, 25)
      .setSize(width-510, 20)
        .setRange(0, 27)
          .setNumberOfTickMarks(28)
            .setDecimalPrecision(3) 
              .snapToTickMarks(false)              
                .setValue(0)
                  .setLabelVisible(false)                  
                    .setSliderMode(Slider.FLEXIBLE)
                      .setColorTickMark(color(0, 220))
                        .setColorActive(#00D7FF)
                          ;
 
  //Slider for speed animation selection.
  SliderValue2=cp5.addSlider("sliderValue2")
    .setPosition(width-180, 25)
      .setSize(100, 20)
        .setRange(0, 100)
          .setDecimalPrecision(0)
            .setNumberOfTickMarks(3)
              .snapToTickMarks(false)
                .setValue(25)               
                  .setCaptionLabel("SPEED")  
                    .setColorLabel(color(0))                  
                      .setLabelVisible(true)
                        .setSliderMode(Slider.FLEXIBLE)
                          .setColorTickMark(color(0, 220))
                            .setColorActive(#00D7FF)                                                 
                              ;
                              
  //Slider for flag size
  SliderValue3=cp5.addSlider("sliderValue3")
    .setPosition(220, height-56)
      .setSize(100, 20)
        .setRange(1, 10)
          .setDecimalPrecision(0)
            .setNumberOfTickMarks(3)
              .snapToTickMarks(false)
                .setValue(5)               
                  .setCaptionLabel("SIZE")  
                    .setColorLabel(color(0))                  
                      .setLabelVisible(true)
                        .setSliderMode(Slider.FLEXIBLE)
                          .setColorTickMark(color(0, 220))
                            .setColorActive(#00D7FF)                                                 
                              ;
                              
  //Slider for flag transparency
  SliderValue4=cp5.addSlider("sliderValue4")
    .setPosition(350, height-56)
      .setSize(100, 20)
        .setRange(0, 100)
          .setDecimalPrecision(0)
            .setNumberOfTickMarks(3)
              .snapToTickMarks(false)
                .setValue(20)               
                  .setCaptionLabel("TRANSPARENCY")  
                    .setColorLabel(color(0))                  
                      .setLabelVisible(true)
                        .setSliderMode(Slider.FLEXIBLE)
                          .setColorTickMark(color(0, 220))
                            .setColorActive(#00D7FF)                                                 
                              ;
}

//Control status.
void controlEvent(ControlEvent theControlEvent) {
  // Mapping the animation increment, size, and transparency values ​​of the flag.
  if (theControlEvent.isFrom("sliderValue2")) {
    tInc=map(int(theControlEvent.getController().getValue()), 0, 100, 0.0005, 0.1);
  }
  if (theControlEvent.isFrom("sliderValue3")) {
    size=map(int(theControlEvent.getController().getValue()), 1, 10, 10, 100);
  }
  if (theControlEvent.isFrom("sliderValue4")) {
    trans=map(int(theControlEvent.getController().getValue()), 0, 100, 255, 0);
  }  
  //Activate/Deactivate all Countries
  if (theControlEvent.isFrom(checkbox3)) {  

    if (checkbox3.getState(0)==true)
    {
      for (int i=0; i<Nrows-1; i++) {
        Gcheckbox2[i].activate(0);
      }
    }
    else
    {
      for (int i=0; i<Nrows-1; i++) {
        Gcheckbox2[i].deactivate(0);
      }
    }
  }
}


//The draw function runs every frame indefinitely.
void draw() {   

  background(255);

  //Help text.
  textFont(font1); 
  fill(0, 220);  
  text("Press 'H' to help", 80, 32);
  //Help is H key is pressed.
  if (HPressed==true) {
    Help();
  }  
  
  //Title
  text("Tourism travel expenditure in the EU and UK.", width/2+50, 100);  
  textFont(font4); 
  //Years for slider
  for (int i=0; i<Ncolumns; i++) { 
    text(form2.format(ExpTable.getData(i, 0)), 225+i*40, 60);
  }

  //Repositioning controls.
  SliderValue.setSize(width-510, 20);
  SliderValue2.setPosition(width-180, 25);  
  checkbox.setPosition(width-250, 10); 

  //Show country names in the legend.
  ShowLegend();

  //Controlling animation time increment
  if (checkbox.getState(0)==true) {
    if (t<=0 )
    {
      tInc = abs(tInc);
    }
    else if (t>=Ncolumns-1)
    {
      tInc = -abs(tInc);
    }  
    SliderValue.setValue(t);
    t+=tInc;
  }    

  //Display the graph axes
  DrawAxes();

  //Calculate and display flag positions.
  for (int i=1; i<Nrows; i++) { 
    if (sliderValue<Ncolumns-1){      
      PosData(floor(sliderValue), i);
    }     
    else {  
      PosData(Ncolumns-2, i);
    }
  }//end for

  //Change the color of the radslider arrow when hovering over a year.
  for (float i=0; i<Ncolumns; i++) {  
    if (sliderValue <= i+0.01 && sliderValue >= i-0.01) {      
      SliderValue.setColorActive(#FF0000);
      break;
    }
    else {
      SliderValue.setColorActive(#00D7FF);
    }
  }
  noTint(); 
  MouseClick = 3;
}///////////////////////end Void Draw //////////////////////////

//Tag position.
void PosTooltip() {
  tooltip.setAnchor(Direction.SOUTH_WEST);  
  if (interpx>width-200) {
    tooltip.setAnchor(Direction.SOUTH_EAST);
  }
  if (interpy<200) {
    tooltip.setAnchor(Direction.NORTH_WEST);
  }
  if (interpx>width-200 && interpy<200) {
    tooltip.setAnchor(Direction.NORTH_EAST);
  }
}

//
//float log10 (float x) {
//  return (log(x) / log(10));
//}

void ShowLegend()
{
  textFont(font2); 
  textAlign(LEFT);
  noTint();
  for (int i=0; i<Nrows-1; i++) {       
    if (Gcheckbox2[i].getItem(0).getState()==true)
    {    
      fill(0);
    }
    else
    {    
      fill(180);
    }
    text(Countries[i], 50, 142+(26*i));
  }
  text("All", 50, height-75);
}


void DrawAxes() {

  pushMatrix();
  stroke(#F20707);  
  strokeWeight(2);
  fill(0);  

  //Yaxis title
  translate(170, height/2+50);
  rotate(-PI/2.0);
  textFont(font1); 
  text("Growth (%)", 0, 0);
  rotate(PI/2.0);
  translate(-170, -height/2-50);

  textFont(font2); 
  translate(220, 140);
  //Yaxis
  line(0, 0, 0, height-250);    
  //Divisions
  float tamDivYaxis=(height-260)/10.0; 
  textAlign(RIGHT, CENTER); 
  for (int div = 0; div < 11; div++) {    
    line(0, tamDivYaxis*div, -10, tamDivYaxis*div);   
    text(form1.format(Yaxis[div]), -20, tamDivYaxis*div-2);
  }

  translate(0, height-250);
  //Xaxis
  line(0, 0, width-310, 0);
  //Divisions
  float tamDivXaxis=((width-310)/20);

  textAlign(CENTER, CENTER);      
  for (int div = 0; div < 21; div++) {    
    line(tamDivXaxis*div+10, 0, tamDivXaxis*div+10, 10);   
    text(form1.format(Xaxis[div]), tamDivXaxis*div+8, 20);
  }     

  textFont(font1);
  text("Tourism travel expenditure in US$ millions", width/2.5, 60); 
  popMatrix();
}

//Mouse click detection.
void mousePressed() {   
  if (mouseButton == LEFT) {
    MouseClick=1;
  }
  else if (mouseButton == RIGHT) {
    MouseClick=0;
  }
}

//Detection of the key pressed.
void keyPressed()
{
  if ((key == 'h') || (key == 'H'))
  {
    if (HPressed==false) {
      HPressed = true;
    }
    else
    {
      HPressed = false;
    }
    t2=0;
    t3=0;
    t4=0;
  }
}



