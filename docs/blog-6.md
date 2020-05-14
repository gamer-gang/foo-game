# Blog 6

Hey all, for the past few days ive been working on the game. I've got some new exiting stuff you will be able to play with when the game comes out. 

## Levels
I have made a bit of a tutorial level. It still needs a bit of text to tell you what to do, but I can add that later. Im designing the tutorial after the popular game called [Cuphead](https://cuphead.fandom.com/wiki/The_Tutorial).
![tutorialImage](./images/blog-6-tutorial.png)

## Better physics
Last time, the jumping physics were pretty wack. Instead of having 2 jumps, you had 3. Also sometimes your jump height would be super low. These things got fixed in this version. Holding down the jump button also makes you go higher now. 
![demonstrationVideo](./images/blog-6-video.gif)

Here is an oversimplified version of our movement code:
```dart
void move(gamepad) {
  if (gamepad.left) acceleration.x = acceleration.x - 1;
  if (gamepad.right) acceleration.x = acceleration.y + 1;
  if (gamepad.dash); // not done yet!
  if (gamepad.jump && jumpsLeft != 0) {
    velocity = 0;
    acceleration.y = jumpHeight;
    jumps = jumps - 1;
  }
  
  applyFriction();
  applyGravity();
  
  velocity = velocity + acceleration;
  position = position + velocity;
}
```

Void means that move is a function. Functions are a section of a program that does a spefific task. In this case, the function makes the player move. The gamepad is what we are using to control our character. It is made up of the 4 buttons you see at the bottom. Inside the function, it checks to see if you are pressing a button. If the left button is pressed, 1 will be subtracted from your acceleration. if you press the jump button, it sets your velocity to 0 and your acceleration to the player's jump height. After that, we call 2 functions that apply friction and gravity to our character so it does not move too fast. Then we add acceleration to velocity, and add our velocity to our player's position to finally move it. Later in the code, the character is drawn. 

## Other things
I added a bit of code for having different backgrounds and foregrounds. We plan to use [parallax](https://en.wikipedia.org/wiki/Parallax), where we have multiple layers that are drawn, to make things in our game look nicer. 

Thats all for this update. The code took like 5 hours to make. 

---
© 2020 gamer-gang under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
