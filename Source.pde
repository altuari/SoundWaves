import processing.serial.*; 
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
Serial port;

void setup() {
  // Creating a box so that we know it is working
  size(512, 200, P3D);
  
  minim = new Minim(this);
  port = new Serial(this, "/dev/cu.usbmodem1411301", 9600);
  
  song = minim.loadFile("bxnfire.mp3", 2048); // Songname, Freq rate
  song.play();
  
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(10); // 10 - 300 (The smaller the number the faster we can pick up individual beats)
  
  bl = new BeatListener(beat, song);
}

void draw() {
  background(0);fill(255);
  
  // We have 5 leds so we need 5 if statements
  if(beat.isHat()) { port.write("led2"); };
  if(beat.isSnare()) { port.write("led3"); };
  if(beat.isKick()) { port.write("led4"); };
  if(beat.isOnset(1)) { port.write("led5"); };
  if(beat.isOnset(10)) { port.write("led6"); };
}

void stop() {
  song.close();minim.stop();super.stop();
}
