color imagecolor; // Color of the image (marked by x and y)
color white = color(255,255,255); // Marking a default white color
color black = color(0,0,0); // Marks a default black color
color red = color(255,0,0); // Marks a default red color
color green = color(0,255,0); // Marks a default green color
color blue = color(0,0,255); // Marks a default blue color
int x = 0; // Marks the x coordinate the program is checking from the image.
int y = 0; // Marks the y coordinate the program is checking from the image.
PImage image; // Marks the image that is being displayed.
int totallines = 0; // How many total lines have been displayed (to prevent the 65535 byte limit)
PrintWriter imagecolorwriter; // Marks the text file that everything is being put into.
int newvoids = 1; // How many new voids have been made by the program (to prevent the 65535 byte limit)
int randomNumber = int(random(0,1000000)); // Makes the random number an integer.
String capturename; // Makes the string of the name of the capture, but is never used here. Look at the stuff to mess with instead.


// ------ HERE'S SOME STUFF TO MESS WITH --------- \\

// If you want to change what image you're using, go to line 64.
String backgroundcolor = "color(255,255,255)"; // What color you want the backgroud of the new image.
String foregroundcolor = "color(0,0,0)"; // What color you want the foreground of the new image (note this is only used if monochrome is on).
int monochrome = 0; // Whether or not you want the image in one color (basically black and white). 0 = No, 1 = yes. Is no by default.
int randomnaming = 1; // Whether you want the name of the files to be random. 0 = No, 1 = . Is yes by default.
int xlinestoskip = 1; // How much of the X coordinate should be skipped. 1 by default means no skip, 2 gives it a more dot-like feel.
int ylinestoskip = 2; // How much of the Y coordinate should be skipped. 2 by default means skip every other line, 1 means don't skip (not recommended).
String codename = "InstantPointDrawings/" + "image/" + "image.pde"; // Sets the string the name of the code file.
{
if (randomnaming == 1) {
capturename = "\"captures/\"+" + "\"Lined_image_" + randomNumber + " .png\""; // Sets the string the name of the capture file.
}
if (randomnaming == 0) {
capturename = "\"captures/\"+" + "\"Lined_image_######.png\""; // Sets the string the name of the capture file.
}
}

// ----------------------------------------------- \\

void setup() {
  imagecolorwriter = createWriter("" + codename + ""); // Makes the file where the code is ran.
  size(200,200); // Screen dimensions. Matching to the image resolution is preferred, though not nessecary.
  frameRate(60); // 60 FPS (doesn't really matter)
  
  // ------- BELOW UNTIL I SAY SO IS PUTTING DEFAULT COLORS, SETUP AND DRAW INTO THE NEW FILE. ---------- \\
  imagecolorwriter.println("color black = color(0,0,0);");
  imagecolorwriter.println("color white = color(255,255,255);");
  imagecolorwriter.println("color red = color(255,0,0);");
  imagecolorwriter.println("color green = color(0,255,0);");
  imagecolorwriter.println("color blue = color(0,0,255);");
  imagecolorwriter.println("color yellow = color(255,255,0);");
  imagecolorwriter.println("color purple = color(255,0,255);");
  imagecolorwriter.println("color backgroundcolor = " + backgroundcolor + ";");
  imagecolorwriter.println("color foregroundcolor = " + foregroundcolor + ";");
  imagecolorwriter.println("int printedimage = 0;"); // Integer signifying whether it has saved a screenshot already.
  imagecolorwriter.println("");
  imagecolorwriter.println("void setup() {");
  imagecolorwriter.println("size(" + width + "," + height + ");");
  imagecolorwriter.println("frameRate(60);");
  imagecolorwriter.println("}");
  imagecolorwriter.println("");
  imagecolorwriter.println("void draw() {");
  imagecolorwriter.println("background(backgroundcolor);"); // Puts the background. Change if you want a different background color.
  // ------- OKAY NOW I SAY SO ---------- \\
  
  image = loadImage("image.jpg"); // What image you're searching for. THIS IS VERY IMPORTANT.
  int dimension = width / xlinestoskip * height / ylinestoskip; // Mark the dimensions of the screen.
  image.resize(width, height); // Resize the image you signified to match the screen.
  image.loadPixels(); // Load the pixels of your image.
  for (int i = 0; i < dimension; i += 1) { // Until you reach the end of the image...
    imagecolor = image.get(x, y); // Get the pixel color of the part of the image matching the x and y coordinate signified.
    if (imagecolor != black) { // If you want to get the lines effect, set this from (imagecolor != [your bg color]) to (imagecolor == [your bg color])
    // Lines look better but need to be done under lower resolutions to prevent Java from crapping out.
        if (totallines < 1000 && monochrome == 0) { // If you've done under 1000 lines and you want color...
        int redimagecolor = int(red(imagecolor)); // Pull the red value from the imagecolor.
        int greenimagecolor = int(green(imagecolor)); // Pull the green value from the imagecolor.
        int blueimagecolor = int(blue(imagecolor)); // Pull the blue image from the color value.
        imagecolorwriter.println("set(" + x + "," + y + ",color(" + redimagecolor + "," + greenimagecolor + "," + blueimagecolor + "));"); // Set with colors.
        }
        if (totallines < 1000 && monochrome == 1) { // If you've done under 1000 lines and you want monochrome...
        imagecolorwriter.println("set(" + x + "," + y + ",foregroundcolor);"); // Put the set command. Change the black for a different color.
        }
        totallines += 1; // Add one to the number of total lines.
        if (totallines >= 1000) { // If you've done 1000 lines or more...
          imagecolorwriter.println("additionalLines" + newvoids + "();"); // Make a new function
          imagecolorwriter.println("}");
          imagecolorwriter.println("void additionalLines" + newvoids + "() {");
          totallines = 0; // Set the lines back to 0 to signify that you don't need a new void.
          newvoids += 1; // Increase a variable saying you've made a new void.
        }
  }
    if (x >= width) { // If the x coordinate has reached the end...
      x = 0; // Set the X to 0.
      y += ylinestoskip; // Add the value set for ylinestoskip to Y...
    } // I would use an else but they don't want to work :\
    if (x < width) { // If the x coordinate hasn't reached the end...
      x += xlinestoskip; // Add the value set for xlinestoskip to X...
    }
  } // Once the loop is over and you've reached the end...
  imagecolorwriter.println("if(printedimage == 0){"); // Basically stops it from repeatedly printing screenshots.
  String value = "saveFrame(" + capturename + "); ";
  imagecolorwriter.println("" + value + "");
  imagecolorwriter.println("printedimage = 1;");
  imagecolorwriter.println("}");
  imagecolorwriter.println("}"); // Put the final bracket.
  imagecolorwriter.flush(); // And end the text file.
  imagecolorwriter.close();
  image.updatePixels(); // Then update pixels to indicate resizing and other things.
}

void draw() {
  image(image, 0, 0, width, height); // Draw the image after being resized, for comparisons sake.
}
