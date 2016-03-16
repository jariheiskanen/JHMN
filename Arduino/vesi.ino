/*Tämä ohjelma lukee antureiden dataa ja lähettää ne ThingSpeakiin
TO DO:
-Siisti koodirakennetta
-Lähettää datan raspille käyttämällä MQTT:tä
-Täytyy lisätä RF-koodi tähän koodiin
*/

#include<HttpClient.h>
#include<eHealth.h>
#include <PinChangeInt.h>
#include "ThingSpeak.h"
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x0F, 0xC6, 0x7C};
EthernetClient client;
int analogPin = 0; // water sensor connected to the analog port 1
int val = 0; // definition variable val initial value as 0
int vesi = 0; // definition variable vesi initial value as 0
int cont = 0;
unsigned long myChannelNumber = 66574;
const char * myWriteAPIKey = "PKKM6DP4JUIV25Q7";

//  VARIABLES
int pulsePin = 0;                 // Pulse Sensor purple wire connected to analog pin 0
int blinkPin = 9;                // pin to blink led at each beat
int fadePin = 5;                  // pin to do fancy classy fading blink at each beat
int fadeRate = 0;                 // used to fade LED on with PWM on fadePin
float temperature=0;
float air=0;

// these variables are volatile because they are used during the interrupt service routine!
volatile int BPM;                   // used to hold the pulse rate
volatile int Signal;                // holds the incoming raw data
volatile int IBI = 600;             // holds the time between beats, the Inter-Beat Interval
volatile boolean Pulse = false;     // true when pulse wave is high, false when it's low
volatile boolean QS = false;        // becomes true when Arduoino finds a beat.

void setup ()
{
  Serial.begin(115200 ); // set the baud rate as 9600
  Ethernet.begin(mac);  
  Serial.println(Ethernet.localIP());
   Serial.print("hello");
  ThingSpeak.begin(client);
  //pinMode (led, OUTPUT); // definition led as output pin
  interruptSetup();                 // sets up to read Pulse Sensor signal every 2mS 
}

void loop ()
{
  readSensors();
  delay(20); 
}

void InitialiseInterrupt(){
  cli();    // switch interrupts off while messing with their settings  
  PCICR =0x02;          // Enable PCINT1 interrupt
  PCMSK1 = 0b00000001;
  sei();    // turn interrupts back on
}

ISR(PCINT1_vect)
{
  Serial.println("Pissa tuli"); // serial print variable vesi
}

//Include always this code when using the pulsioximeter sensor
//=========================================================================
void readPulsioximeter(){  

  cont ++;

  if (cont == 50) { //Get only of one 50 measures to reduce the latency
    eHealth.readPulsioximeter();  
    cont = 0;
  }
}
void sentToThingSpeak(float t, float a, float p, float ibi, float k)
{
  char server[] = "api.thingspeak.com";
  String apistring = String("/update?api_key=PKKM6DP4JUIV25Q7");
  apistring += "&field1=";
  apistring += t;
  apistring += "&field2=";
  apistring += a;
  apistring += "&field3=";
  apistring += p;
  apistring += "&field4=";
  apistring += ibi;
  apistring += "&field5=";
  apistring += k;
  Serial.println(apistring);
  if (client.connect(server, 80)) {
    Serial.println("connected");
    // Make a HTTP request:
    client.print("GET "); 
    client.print(apistring);
    client.println(" HTTP/1.1");
    client.println("Host: api.thingspeak.com");
    client.println("Connection: close");
    client.println();
  } else {
    // if you didn't get a connection to the server:
    Serial.println("connection failed");
  }
  Serial.println("data lähetetty");

  while(client.connected())
  {
   if(client.available())
    {
      char c = client.read();
      Serial.print(c);
    }     
  }
   client.stop(); 
}

void sendDataToProcessing(char symbol, int data )
{
    Serial.print(symbol);                // symbol prefix tells Processing what type of data is coming
    Serial.println(data);                // the data to send culminating in a carriage return
}

void readSensors()
{
  //lämpö
  temperature = eHealth.getTemperature();
 
  //vesi
  val = analogRead (analogPin); // read the simulation value and send to variable val
  vesi = val; // variable val assignment to variable vesi
 
  //hengitys
  air = eHealth.getAirFlow();   
 
  //pulssi
  // sendvesiToProcessing('S', Signal);     // send Processing the raw Pulse Sensor data
  if (QS == true)
  {                       // Quantified Self flag is true when arduino finds a heartbeat
    //    fadeRate = 255;                  // Set 'fadeRate' Variable to 255 to fade LED with pulse
        sendDataToProcessing('B',BPM);   // send heart rate with a 'B' prefix
        sendDataToProcessing('Q',IBI);   // send time between beats with a 'Q' prefix
        QS = false;                      // reset the Quantified Self flag for next time    
  }
}

