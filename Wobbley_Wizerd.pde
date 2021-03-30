//Ryken Santillan
//12/18/2018
//Mr.Rosen
//This program is the final draft of my game, Wobbley Wizerd. Improvements all around have been made.

/* Newly Added Command:
 String=String.replace('oldChar', 'newChar');
 What this function does is that it obtains whatever is stored inside the string, searches for the character listed in the parameter oldChar, and replaces it with the parameter listed in newChar. 
 Strings can be written inside oldChar or newChar if double quotation marks are used to enclose it, taking on the form of: String=String.replace("oldString", "newString");.
 
 Why it's used in this program:
 I used this in my program because negative numbers, even if errorTrapped, cause my program to crash. Using this, I can replace the negative sign (-), with a string, causing it's integer value to become 0.
 Additionally, input.pde will always receive priority when I attempt to enter a level. Therefore, to improve user-friendliness instead of just allowing users to enter a negative number or a string to continue,
 I created a new variable and used the String=String.replace("oldString", "newString"); command. If the variable  is equal to 1, any number entered will give // as it's result. 
 When the stage shows successfully, the variable is now 0, allowing users to play the game.
 
 MUST READ:
 Unbeknowst to me in the previous drafts, no matter how much key input will be blocked, smashing the keyboard or pressing so many keys at once while the wizerd is moving will glitch the game. Therefore, I created a reset that will slightly work.
 Whilst the wizerd is moving, and keys are pressed, it sends the user back to main menu for disregarding important tips firstly. Since only so little can be done, only if the user enters levelSelector() and selects the appropriate level,
 they are sent back to where they left off (pillar distance), but with their score reset! Pressing the mouse simply accelerates the wizerd.
 */



//------------------------------------------------------------------------------Declaration Section------------------------------------------------------------------------------


//-----------------------------------Integers in Casual Program Order-----------------------------------

int circleX; // circleX is used in the splash screen. It is the start of the splash screen, as the x-diameter of the white ellipse opening up to the studio name.
int circleY; //  circleY is used in the splash screen. It is the start of the splash screen, as the y-diameter of the white ellipse opening up to the studio name.
int studioY; // The animation controller of my studio name. In the splash screen, when the white ellipse clears the black background, my studio name will come down. studioY controls the movement of the studio name's y-position
int leftDoorX; // When my studio name comes down and stops, a door on the left will move in towards the right and stop midway. leftDoorX controls the movement of the door.
int rightDoorX; // When my studio name comes down and stops, a door on the right will move in towards the left and stop midway. rightDoorX controls the movement of the door.
int purpleY; // After the door animation, a purple screen will come up to cover it. purpleY controls this action.
int introTextY; // My introText, "Wobbley Wizerd" -- spelt incorrectly on purpose, will appear after the purpleY stops.
int randomPlatformDistance = int(random(150, 651)); // the random platform distance in playGame(); that will change. It is first defined here to have a distance at the beginning of playGame();.
int tutorialBox = 1; // When tutorialBox is 1, and tutorial(); is open, userInput(); will run.
int playGameBox = 1; // When playGameBox is 1, and playGame(); is open, userInput(); will run.
int wizerdMoveX = 50; // wizerdMoveX is the wizerd's starting x-position.
int wizerdMoveY = 250; // wizerdMoveY is the wizerd's starting y-position.
int score; // Keeps track of the score.
int starterPositive;  // Allows positive numbers to be used when the input box appears before the stage or level.
int endCircleX; // The end x-coordinate point which will activate when goodbye(); is open. When it reaches the end of the screen, the program closes.

//-----------------------------------String, Color, PFont, and PImage-----------------------------------

color colorChangePlayGame = color(255, 140, 0); // Supposed to be local in the plan, but changes were made. This changes the color of the Play Game  Option when the user hovers over Play Game.
color colorChangeTutorial = color(255, 140, 0); // Supposed to be local in the plan, but changes were made. This changes the color of the Tutorial Option when the user hovers over Tutorial.
PFont font; // The font of the text.
PImage wizerdSprite; // Wizerd Sprite taken from online. It looks fabulous -- classic 2D pixelated 8-bit wizerd.
String distance; // This will be the distance of the bridge, in pixels.

//-----------------------------------Booleans in Alphabetical Order-----------------------------------

boolean bye = false; // Controls whether goodbye(); opens.
boolean choose; // Decision-based boolean for scoreBox. When it's true it runs the message for tutorial();, and when false, it runs the messages for playGame();. This is newly-added and was not in the plan.
boolean instructionBox; // Controls whether instructions(); is closed or not.
boolean keysNotAvailable = true; // Controls some keyPressed(); options.
boolean levelSelectorStatus = false; // Controls whether levelSelector(): is open or not.
boolean mainMenuBox = false; // Controls whether the mainMenu(); screen and what's inside is active except levelSelector();.
boolean mouseNotAvailable = true; // Controls some mousePressed(); options.
boolean openPlayGame = false; // Controls whether what's inside playGame(); will run or not.
boolean openTutorial = false; // Controls whether what's inside tutorial(); will run or not.
boolean positiveAllowed; // Recently added to control game flow. Used inside playGame(); to allow anything to be entered to continue to the next level.
boolean runningIntro = true;  // Used for the keyPressed entrance to mainMenu();
boolean scoreBox = false; // Administrates the opening of scoreBox(); or not.




//------------------------------------------------------------------------------Size and wizerd image setup!------------------------------------------------------------------------------

void setup() {
  size(800, 500); // Sets the size to 800-by-500 pixels.
  wizerdSprite=loadImage("wizerdSprite.png"); // Gives the 6 kilobyte wizerdSprite.png life inside this program.
}



//------------------------------------------------------------------------------Code that needs to run continuously!------------------------------------------------------------------------------

void draw() {
  background(0); // Sets the background to black at the beginning for the splashScreen.
  splashScreen(); // This will run splashScreen();
  if (keysNotAvailable == false) { // Controls some of the keyPressed(); options. Although the code is perfect in it's sense, some keyPressed actions escape this when boolean statements are called.
    keyPressed();
  }
  if (mouseNotAvailable == false) { // Controls some of the mousePressed(); options. Although the code is perfect in it's sense, some mousePressed actions escape this when boolean statements are called.
    mousePressed();
  }
  if (scoreBox) { // Ran in draw to run scoreBox(); if it senses scoreBox to evaluate as true. It is placed here as other places make it unable to work.
    scoreBox();
  }
}



//------------------------------------------------------------------------------Splash Screen~! Leads to introduction...------------------------------------------------------------------------------

void splashScreen() {
  fill(255); // White .
  ellipse(400, 250, circleX, circleY); //  White ellipse for splash screen.
  circleX+=10; // Makes the circle's x-diameter increase by 10 pixels continuously.
  circleY+=5;  // Makes the circle's y-diameter increase by 5 pixels continuously.
  fill(0); // Black .
  if (circleX > 800 || circleY > 500) { // Conditional that will bring upon my studio name.
    textSize(25); // Stts the text size to 25.
    text("Keybored Warrior Presents:", 250, studioY); // My Studio Name.
    studioY+=8; // Makes my Studio Name go down at a speed of 8 pixels.
  }
  if (studioY >= 250) { // Conditional that will bring upon the doors left and right when studioY >= 250.
    studioY-=8; // Stops the Studio Name from resuming movement.
    fill(139, 69, 19); // Brown.
    rect(0, 0, leftDoorX, 500); // The Left Door Rectangle Frame.
    leftDoorX+=4; // Makes the left door move to the right at a speed of 4 pixels.  
    rect(800, 0, rightDoorX, 500); // The Left Door Rectangle Frame.
    rightDoorX-=4;  // Makes the right door move to the left at a speed of 4 pixels.  
    fill(255, 255, 0); // Yellow.
    ellipse(leftDoorX-30, 250, 20, 20); // The Left Door Ellipse Handle.
    ellipse(rightDoorX+830, 250, 20, 20); // The Right Door Ellipse Handle.
  }
  if (rightDoorX <= 395 && leftDoorX >= 405) { // Conditional that will bring the purple background up when rightDoorX <= 395 && leftDoorX >= 405.
    leftDoorX-=4; // Stops the left door's movement.
    rightDoorX+=4; // Stops the right door's movement.
    fill(100, 0, 255); // Purple.
    rect(0, purpleY+500, 800, 510); // Purple Rectangle.
    purpleY-=5; // Makes the purple rectangle move up at a speed of 5 pixels.
  }
  if (purpleY+500 <= -10) { // Conditional that opens up to introduction when purpleY+500 <= -10.
    purpleY+=5; // Stops the purple rectangle's movement.
    introduction(); // Calls Introduction.
  }
}



//------------------------------------------------------------------------------Title as introduction!------------------------------------------------------------------------------

void introduction() {
  for (int i = 0; i <= width; i++) { // For Loop that creates the gradient background.
    stroke(i-40, i-100, i-150);
    line(i, 0, i, height);
  }
  font = createFont("pathOfWobbley.vlw", 70); // Loads the font to the font I selected and named, with a text size of 70.
  textFont(font); // Sets the font to the font I selected and named.
  fill(255, 0, 0); // Red
  text("WOBBLEY WIZERD!", 50, introTextY); // My Title "WOBBLEY WIZERD".
  introTextY+=4; // Makes my title go down at a speed of 4 pixels.
  textSize(40); // Sets the text size to 40.
  text("Press any key to begin!", 280, introTextY+200); // Gives the user a message that to continue, any key should be pressed.
  if (introTextY >= 200) { // A Conditional for if my title reaches a certain position -- introTextY >= 200 -- the user may enter a key to continue as the following boolean values are changed.
    introTextY-=4; // Stops the title from moving.
    runningIntro = false; // The intro is not running anymore.
    keysNotAvailable=false; // Keys are available.
  }
}



//------------------------------------------------------------------------------Main Menu Consisting of Three Options. Uses keyPressed();------------------------------------------------------------------------------

void mainMenu() {  
  textSize(42); // Sets the text size to 42.
  fill(255, 105, 180); // Pink.
  rect(0, 0, 800, 500); // Pink Rectangle as the background.
  fill(152, 255, 152); // Mint.
  text("Press 1: Instructions", 220, 150); // Option 1. Press the '1' key to access.
  text("Press 2: Level Selector", 220, 250); // Option 2. Press the '2' key to access.
  text("Press 3: Exit", 220, 350); // Option 3. Press the '3' key to access.
  score=0; // Score resets to 0 in case a game has already been played, so it won't keep the score for the next round. 
  starterPositive=1; // This allows positive input to make the stage appear.
}



//------------------------------------------------------------------------------keyPressed(); options. Different events triggered by different conditions!------------------------------------------------------------------------------

void keyPressed() {
  if (keyPressed && key != '1' && key !='2' && key != '3' && runningIntro == false  && keysNotAvailable == false) { // If a key is pressed whilst the Title is down, it makes mainMenuBox true.
    mainMenuBox=true;
  }
  if (mainMenuBox) { // When mainMenuBox is true, it will continuously run mainMenu();. This is done to prevent it from blinking into it and then leaving as soon as the key is up.
    mainMenu();
  }
  if (key == '1'  && keysNotAvailable == false && mainMenuBox) { // Calls instructions(); and makes instructionBox true.
    instructions();
    instructionBox=true;
  } else if (key != '1' && key != '2' && key != '3' && keyCode != RIGHT && keyCode != LEFT && levelSelectorStatus==false && keysNotAvailable == false && instructionBox) { // A conditional that allows the user to return to mainMenu(); if any other key than 1, 2, 3, ← , or → is pressed.
    instructionBox=false;
  } else if (key == '2'  && instructionBox  && levelSelectorStatus==false && keysNotAvailable == false && mainMenuBox) { // Prevents levelSelector(); from working inside instructions():
    instructions();
  } else if (key == '3'  && instructionBox && levelSelectorStatus==false && keysNotAvailable == false && mainMenuBox) { // Prevents goodbye(); from working inside instructions():
    instructions();
  } else if (key == '2' && instructionBox == false && keysNotAvailable == false && mainMenuBox) { // If '2' is pressed outside of instructions(); and exit(); it makes levelSelectorStatus true.
    mainMenuBox = false;
    levelSelectorStatus=true;
  } else if (key == '3' && instructionBox == false && levelSelectorStatus==false && keysNotAvailable == false && mainMenuBox) { // If '3' is pressed outside of instructions(); or levelSelector(); it will make bye true.
    bye = true;
  }
  if (keyCode == RIGHT && instructionBox) { // A conditional for when inside instructions(); and → is pressed, it turns into a screen called Important Tips!
    fill(100, 0, 255); // Purple.
    rect(0, 0, 800, 500); // Purple Rectangle as the background.
    fill(255, 255, 0); // Yellow.
    text("Important Tips:", 280, 40); 
    textSize(17); // Sets the text size to 20.
    text("1. In Level Selector, if you click Tutorial or Play Game and the level does not show, enter anything for it to appear. The input box receives priority, which is why this has to be done.", 0, 70, 800, 500);
    text("2. In Play Game, if you reach the other side successfully, enter anything for the distance of the bridge to change, and for your wizerd to be reset to the original position!", 0, 160, 800, 500);
    text("3. As mousePressed and keyPressed can be glitchy, PLEASE do not fiddle or interact with ANY key or mouse actions unless required! After each game or tutorial run-through, please click the mouse at least once to reset it. Pressing too many keys at once in-game will send you back to the main menu.", 0, 250, 800, 500);
    text("Press the ← key to go back to Instructions!", 0, 490);
    fill(255, 20, 147); // Pink.
    ellipse(500, 410, 600, 70); // Pink Ellipse.
    fill(0); // Black
    textSize(17); // Sets the text size to 17.
    text("Press any key other than 1, 2, 3, ← , or → to return to Main Menu!", 260, 410);
  } else if (keyCode == LEFT && instructionBox) { // Specific keycheck for when in instructions(); and ← is pressed, it reverts back to the original instructions();. not stuck at Important Tips.
    instructions();
  }
  if (levelSelectorStatus) { // If levelSelectorStatus is true, it will run levelSelector();, and makes mouse interactions available.
    levelSelector();
    mouseNotAvailable = false;
  }
  if (levelSelectorStatus && key != '1' && key != '2' && key != '3' &&  openTutorial == false && openPlayGame == false && keyPressed) { // If levelSelector is running and another key other than 1, 2, or 3 is pressed, it returns the user back to mainMenu();
    levelSelectorStatus=false;
    mainMenuBox=true;
  }
  if (scoreBox && keyPressed && key != '1' && key != '2' && key != '3') { // If in scoreBox, and another key other than 1, 2, or 3 is pressed, it returns the user back to mainMenu();  Not connected to other if statements.
    mainMenuBox=true;
    scoreBox=false;
  }
  if (bye) { // If bye is true, goodbye(); will run. Not connected to other if statements.
    goodbye();
  }
    if (openTutorial && keyPressed) { // If user disregards the idea of not fiddling with key-interaction, this conditional saves the program from glitching out.
    openTutorial=false; // Closes tutorial();
    wizerdMoveX=50; // Reset's wizerd's Position.
    wizerdMoveY=250; // Resets wizerd's Position.
  } else if (openPlayGame && keyPressed) { // If user disregards the idea of not fiddling with key-interaction, this conditional saves the program from glitching out.
    openPlayGame=false; // Closes playGame();
    wizerdMoveX=50; // Resets wizerd's Position.
    wizerdMoveY=250; // Resets wizerd's Position.
  }
}



//------------------------------------------------------------------------------Instructions for the game. Tied to Important Tips.------------------------------------------------------------------------------

void instructions() {
  fill(100, 0, 255); // Purple.
  rect(0, 0, 800, 500); // Purple Rectangle as the background.
  fill(255, 255, 0); // Yellow.
  text("Instructions:", 300, 40); 
  textSize(20); // Sets the text size to 20.
  text("Fellow wizerd, you are amongst the tens of people who played this game… Your mission? Survive! In each level, you are to enter a distance, in which a bridge from one pillar to the other will be created, type carefully! Each successful build will reward a point. Falling will end your streak. Tutorial is Play Game without the points, and with a fixed pillar distance. Test distances in tutorial! To prevent the game from being too hard, the bridge is allowed to be at most, 50 pixels above the exact bridge value, but not below. Good luck, wizerd... ", 0, 100, 800, 500);
  text("Press the → key to go to Important Tips!", 0, 490);
  fill(255, 20, 147); // Pink.
  ellipse(500, 410, 600, 70); // Pink Ellipse.
  textSize(17); // Sets the text size to 17.
  fill(0); // Black.
  text("Press any key other than 1, 2, 3, ← , or → to return to Main Menu!", 260, 410);
}



//------------------------------------------------------------------------------Level Selector------------------------------------------------------------------------------

void levelSelector() {
  fill(0, 255, 0); // Green.
  rect(0, 0, 800, 500); // Green Rectangle as the background.
  fill(colorChangeTutorial); // Orange.
  rect(160, 60, 180, 160); // Orange Rectangle for Tutorial.
  fill(colorChangePlayGame); // Orange.
  rect(160, 240, 180, 160); // Orange Rectangle for Play Game.
  fill(0); // Black.
  textSize(25); // Sets the text size to 25.
  text("Tutorial", 205, 120, 180, 160);
  text("Play Game!", 184, 300, 180, 160);
  text("Please Select Your Option Using The Mouse! To Return To Main Menu, Press Any Key Other Than 1, 2, or 3.", 450, 100, 300, 200);
  fill(0, 0, 255); // Blue.
  textSize(23);
  text("→Stage not appearing? Press the OK button or enter anything to continue!←", 10, 420, 800, 80);
  text("→→Whilst playing, do not fiddle or interact with any key unless required!←←", 10, 460, 800, 80);
  if (mouseX >=160 && mouseX<=340 && mouseY >=60 && mouseY <= 220) { // Conditional for when the mouse hovers over Tutorial, colorChangeTutorial becomes red. 
    colorChangeTutorial = color(255, 0, 0);  // This is Red. This also prevents ANY possibility of overlapping causing both squares to turn red.
    colorChangePlayGame = color(255, 140, 0); // Orange.
  } else {
    colorChangeTutorial = color(255, 140, 0);  // Orange.
  }
  if (mouseX >=160 && mouseX<=340 && mouseY >=240 && mouseY <= 400) {  // Conditional for when the mouse hovers over Play Game, colorChangePlayGame becomes red. 
    colorChangePlayGame = color(255, 0, 0); // This is Red. This also prevents ANY possibility of overlapping causing both squares to turn red.
    colorChangeTutorial = color(255, 140, 0); // Orange.
  } else {
    colorChangePlayGame = color(255, 140, 0); // Orange.
  }
}



//------------------------------------------------------------------------------mousePressed(); options. Different events triggered by different conditions!------------------------------------------------------------------------------

void mousePressed() {
  if (levelSelectorStatus && mousePressed && mouseX >=160 && mouseX<=340 && mouseY >=60 && mouseY <= 220 && mouseNotAvailable == false && openPlayGame == false) { // Conditional for If Tutorial is clicked, openTutorial becomes true.
    openTutorial = true; // Will run tutorial();
  } else if (levelSelectorStatus && mousePressed && mouseX >=160 && mouseX<=340 && mouseY >=240 && mouseY <= 400 && mouseNotAvailable == false && openTutorial == false) { // Conditional for If Play Game is clicked, openPlayGame becomes true.
    openPlayGame = true; // Will run playGame();
  }    
  if (openTutorial) { // If openTutorial is true, tutorial(); will run and mouse and key Interactions will stop for anything other than levelSelector();.
    tutorial();       // levelSelector(); has to be open in order for tutorial(): or playGame(); to be open and so, if you hold down a key, you can see that levelSelector(); pops up but you cannot interact with it. It only prevents you from seeing the screen.
    mouseNotAvailable = true; // Some mouse interactions are stopped.
    keysNotAvailable = true;  // Some keyboard interactions are stopped.
  } else if (openPlayGame) { // If openPlayGame is true, playGame(); will run and mouse and key Interactions will stop for anything other than levelSelector();.
    playGame(); // Calls playGame();
    mouseNotAvailable = true; // Some mouse interactions are stopped.
    keysNotAvailable = true; // Some keyboard interactions are stopped.
  }
}



//------------------------------------------------------------------------------Stage and Setup for tutorial();------------------------------------------------------------------------------

void tutorial() {
  noStroke(); // Strokes are disabled.
  fill(0, 255, 158); // Green.
  rect(0, 0, 800, 500); // Green Rectangle as the background.
  fill(19, 24, 98); // Purple.
  arc(150, 0, 600, 400, radians(0), radians(180));
  arc(600, 0, 600, 700, radians(0), radians(180));
  fill(255);
  ellipse(650, 100, 150, 150);
  fill(0, 255, 158); // Green,
  arc(50, 350, 200, 400, radians(-180), radians(0), PIE); // Hills.
  arc(150, 250, 200, 300, radians(-180), radians(0), PIE);
  arc(350, 350, 200, 450, radians(-180), radians(0), PIE);
  arc(450, 350, 200, 300, radians(-180), radians(0), PIE);
  fill(211, 211, 211); // Grey.
  triangle(300, 50, 60, 350, 400, 350); // Mountain Grey Base.
  fill(255); // White.
  triangle(300, 50, 243, 120, 323, 120); // Mountain White Ice Cap
  fill(0); // Black.
  rect(50, 370, 50, 130); // Starting Pillar.
  rect(50+250, 370, 50, 130); // End Pillar.
  fill(255, 0, 0); // Red
  text("Test Distances Here!", 290, 40);
  wizerd(); // Calls wizerd(); for the wizerd to appear.
  boxes(); // Calls boxes(); for userInput(); to appear.
}



//------------------------------------------------------------------------------Stage and Setup for playGame():------------------------------------------------------------------------------

void playGame() {
  noStroke(); // Strokes are disabled.
  fill(0, 255, 158); // Green.
  rect(0, 0, 800, 500); // Green Rectangle as the background.
  fill(19, 24, 98); // Purple.
  arc(150, 0, 600, 400, radians(0), radians(180));
  arc(600, 0, 600, 700, radians(0), radians(180));
  fill(255);
  ellipse(650, 100, 150, 150);
  fill(0, 255, 158); // Green,
  arc(50, 350, 200, 400, radians(-180), radians(0), PIE); // Hills.
  arc(150, 250, 200, 300, radians(-180), radians(0), PIE);
  arc(350, 350, 200, 450, radians(-180), radians(0), PIE);
  arc(450, 350, 200, 300, radians(-180), radians(0), PIE);
  fill(211, 211, 211); // Grey.
  triangle(300, 50, 60, 350, 400, 350); // Mountain Grey Base.
  fill(255); // White.
  triangle(300, 50, 243, 120, 323, 120); // Mountain White Ice Cap
  fill(0); // Black.
  rect(50, 370, 50, 130); // Starting Pillar.
  rect(randomPlatformDistance+100, 370, 50, 130); // End Pillar that will change.
  wizerd(); // Calls wizerd(); for the wizerd to appear.
  boxes(); // Calls boxes(); for userInput(); to appear.
  fill(255, 0, 0); // Red.
  textSize(18); // Sets the text size to 18.
  text("Score: "+ score, 610, 100); // The red text on the moon will be shown as the score.
}



//--------------------------------------------------------------------------------Controls the activity of userInput();------------------------------------------------------------------------------

void boxes() {
  while (openTutorial && tutorialBox == 1 ) { // Powerful while loop that will run userInput(); on these specific conditions.
    userInput();
  }
  while (openPlayGame && playGameBox == 1 && wizerdMoveX == 50 && wizerdMoveY == 250) { // Powerful while loop that will run userInput(); on these specific conditions.
    userInput();
  }
  display(); // display(); is called here to prevent null pointer exceptions.
}



//--------------------------------------------------------------------------------userInput(); This is the distance of the bridge.------------------------------------------------------------------------------

void userInput() {
  distance=getString("Enter a distance the bridge should be horizontally!"); // This will receive userInput(): as a string, and it will be converted into an int later.
  if (openTutorial) {  // These two statements make sure that the respective Box is subtracted from when the respective gamemode is opened. This will close the input boxes.
    tutorialBox=0;
  } else if (openPlayGame) {
    playGameBox=0;
  }
  distance=distance.replace("-", "//"); // Newly added function. For an unknown reason, negatives cause my program to glitch, even if I errorTrap it. To prevent this, I replace the "-" character in my strings with a //. This makes it into a string which gives it a value of 0.
}



//------------------------------------------------------------------------------Bridge Display and errorTraps related to it------------------------------------------------------------------------------

void display() {
  if (starterPositive == 1) { // Conditional that allows the stage to show.
    distance=distance.replace("1", "//").replace("2", "//").replace("3", "//").replace("4", "//").replace("5", "//").replace("6", "//").replace("7", "//").replace("8", "//").replace("9", "//"); // Newly-added command that allows positive numbers to enter the level.
    wizerdMoveX=50; // Resets the wizerd's position.
    tutorialBox=1; // Run's boxes();
    playGameBox=1; // Run's boxes();
    starterPositive=0; // Allows user input after the initial input to work.
  }
  if (int(distance) > 0 && openTutorial && int(distance) <= 650) { // This conditional states that if the user is in tutorial(); and a distance is entered within range, the bridge will be created and the wizerd will move.
    fill(165, 42, 42); // Maroon.
    rect(100, 370, int(distance), 20); // Bridge with tentative distance is displayed.
    wizerdMoveX+=7; // x-movement starts.
  } else if (int(distance) > 0 && openPlayGame && int(distance) <= 650 && positiveAllowed == false) { // This conditional states that if the user is in playGame(); and a distance is entered within range, the bridge will be created and the wizerd will move.
    fill(165, 42, 42); // Maroon.
    rect(100, 370, int(distance), 20); // Bridge with tentative distance is displayed.
    wizerdMoveX+=7; // x-movement starts.
  } else if (int(distance) <= 0 || int(distance) >= 750) { // If the distance is however, not within acceptable boundaries, the wizerd position is reset and the input box is up again.
    wizerdMoveX=50; // Resets Wizerd's position.
    wizerdMoveY=250; // Resets Wizerd's position.
    tutorialBox=1;  // Runs boxes(); 
    playGameBox=1;  // Runs boxes();
  }
  if (openPlayGame && score >= 1 && int(distance) <= 651 && wizerdMoveX >=50 && positiveAllowed) { // Allows positive input to let the wizerd move to the next level. Should NOT be connected to other if statements.
    wizerdMoveX=50; // Resets Wizerd's position.
    wizerdMoveY=250; // Resets Wizerd's position.
    tutorialBox=1;  // Runs boxes();
    playGameBox=1;  // Runs boxes();
    positiveAllowed = false; // Allows user to resume after level successfully switches.
  }    
  if (openTutorial && int(distance)> 199 && int(distance) < 251 && wizerdMoveX >= 300) { // This conditional statement states that if the user manages to successfully guess the right distance in tutorial();, they are sent to scoreBox.
    wizerdMoveX-=7; // x-movement has stopped.
    wizerdMoveX=50; // Resets Wizerd's position.
    wizerdMoveY=250; // Resets Wizerd's position.
    scoreBox=true; // Runs scoreBox():
    choose=true; // Choose is true and therefore the correct message for tutorial(); will be displayed.
  }
  if (openPlayGame && wizerdMoveX >= int(distance)+80 && int(distance) >= randomPlatformDistance && int(distance) <= (randomPlatformDistance+50)) { // This conditional statement states that if the user manages to successfully guess the right distance in playGame();, they get to continue.
    wizerdMoveX-=7; // x-movement has stopped.
    positiveAllowed=true; // Allows even positive integers to continue to the next level.
    wizerdMoveX=50; // Resets Wizerd's position.
    wizerdMoveY=250; // Resets Wizerd's position.
    score+=1; // Score increases by 1 only as this happens quickly and is interrupted by userInput();
    fill(255, 0, 0); // Red.
    textSize(18); // Sets the text size to 18.
    text("Success! Acceptable distance!", 0, 50);
    text("Enter anything to continue to the next level.", 0, 20);
    randomPlatformDistance=int(random(150, 651)); // Changes the platform distance each time the user successfully guesses an acceptable bridge distance.
    playGameBox=1; // Runs boxes();.
  } 
  if (openTutorial &&  wizerdMoveX >= int(distance)+80 && int(distance) < 200 ||openTutorial &&  wizerdMoveX >= int(distance)+80 && int(distance) >=251) { // This conditional statement explains that if the user has entered an incorrect bridge distance, the wizerd will fall down in the correct spot in tutorial();
    wizerdMoveX-=7; // x-movement has stopped.
    wizerdMoveY+=7; // y-movement starts.
  } else if (openPlayGame && wizerdMoveX >= int(distance)+80 && int(distance) < randomPlatformDistance || openPlayGame && wizerdMoveX >= int(distance)+80 && int(distance) > (randomPlatformDistance+50)) { // This conditional statement explains that if the user has entered an incorrect bridge distance, the wizerd will fall down in the correct spot in playGame():
    wizerdMoveX-=7; // x-movement has stopped.
    wizerdMoveY+=7; // y-movement starts.
  }
  if (openTutorial && wizerdMoveY > 500) { // This conditional says that if inside tutorial(): and the wizerd falls off, the person get's another try.
    text("Re-enter a distance", 20, 80);
    wizerdMoveX=50; // Resets Wizerd's position.
    wizerdMoveY=250; // Resets Wizerd's position.
    tutorialBox=1; // Runs boxes();.
  } else if (openPlayGame && wizerdMoveY > 500) { // This conditional says that if inside playGame(): and the wizerd falls off, the person fails and they are sent to a seperate screen.
    wizerdMoveX=50; // Resets Wizerd's position.
    wizerdMoveY=250; // Resets Wizerd's position.
    scoreBox=true; // Runs scoreBox():
    choose=false; // Choose is false and therefore the correct message for playGame(); will be displayed.
  }
}



//------------------------------------------------------------------------------The wizerd itself! The Grand Mage!------------------------------------------------------------------------------

void wizerd() {
  image(wizerdSprite, wizerdMoveX, wizerdMoveY); // Wizerd's controllable image, given that the x,y coordinates are variables.
}



//------------------------------------------------------------------------------Controls what shows up after success in tutorial or falling down in playGame.------------------------------------------------------------------------------

void scoreBox() {
  if (choose) { // This conditional statement will run the code inside of it when choose is true.
    textSize(25); // Sets the text size to 25.
    openTutorial=false; // tutorial(); is no longer running.
    tutorialBox=1; // tutorialBox is now at 1 so when Tutorial is clicked in levelSelector();, userInput(); will be available.
    levelSelectorStatus=false; // levelSelector(); is no longer running.
    mouseNotAvailable = true; // Mouse interactions are stopped.
    fill(0); // Black.
    rect(0, 0, 800, 500); // Black Rectangle as the background.
    textSize(40); // Sets the text size to 40.
    fill(255, 255, 0); // Yellow.
    text("SUCCESS!", 300, 100); 
    textSize(25); // Sets the text size to 25.
    fill(138, 43, 226); // Blue violet.
    text("*Please click on this screen to reset the mouse*", 140, 30);
    fill(0, 255, 0); // Green.
    text("Now, since you have experimented with distances,", 100, 200);
    text("I suggest you try play game. Good Luck~! Have Fun~!", 90, 300);
    text("Press any key other than 1, 2, or 3 to return to Main Menu!", 70, 400);
    keysNotAvailable=false; // Keys are available so the user can return to mainMenu();.
  } else {  // This conditional statement will run the code inside of it when choose is not true.
    openPlayGame=false; //playGame(); is no longer running.
    playGameBox=1; // playGameBox is now at 1 so when Play Game is clicked in levelSelector();, userInput(); will be available.
    levelSelectorStatus=false; // levelSelector(); is no longer running.
    mouseNotAvailable = true; // Mouse interactions are stopped.
    fill(0); // Black.
    rect(0, 0, 800, 500); // Black Rectangle as the background.
    textSize(40); // Sets the text size to 40.
    fill(255, 0, 0); // Red.
    text("OOPS!", 340, 100); 
    textSize(25); // Sets the text size to 25.
    fill(138, 43, 226); // Blue violet.
    text("*Please click on this screen to reset the mouse*", 140, 30);
    fill(0, 255, 0); // Green.
    text("Your final score is "+ score + "!", 300, 200);
    text("Good luck on another try, please do play again!", 145, 300);
    text("Press any key other than 1, 2, or 3 to return to Main Menu!", 100, 400);
    keysNotAvailable=false; // Keys are available so the user can return to mainMenu();.
  }
}



//------------------------------------------------------------------------------Goodbye Messages + leaves after a while.------------------------------------------------------------------------------

void goodbye() {
  fill(152, 255, 152); // Mint.
  rect(0, 0, 800, 500); // Mint Rectangle as the background.
  fill(0); // Black.
  textSize(30); // Sets the text size to 30.
  text("Thank you for playing.", 100, 250);
  text("Made By Ryken Santillan.", 100, 350);
  text("Keybored Warrior © 2018. All Rights Reserved.", 100, 450);
  textSize(20); // Sets the text size to 20.
  text("Goodbye WIZERD!", endCircleX, 40); // Text that uses endCircleX as it's x-coordinate to animate.
  endCircleX+=8; // This makes the text's x-coordinate move to the right at a speed of 8 pixels.
  if (endCircleX >=800) { // When the text's x-coordinate reaches the end, it exits!
    System.exit(0); // Newly-added exiting command not taught in the curriculum. It is however, included in the ISP plan!
  }
}

//------------------------------------------------------------------------------The End! Comments Continue in input.pde!------------------------------------------------------------------------------