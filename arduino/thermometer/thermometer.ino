#include <max6675.h>
#include <RTC.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <LiquidCrystal_I2C.h>

int thermoDO = 2; 
int thermoCS = 3;
int thermoCLK = 4;

MAX6675 thermocouple(thermoCLK, thermoCS, thermoDO);
int vccPin = 5;
int gndPin = 6;

int MeasurePeriod = 3000;

int IterationsBeforeFlush = 20;

int CounterSinceLastMeasure = 0;

static DS1307 RTC;

LiquidCrystal_I2C lcd(0x3e, 16, 2);

uint8_t degree[8]  = {140,146,146,140,128,128,128,128};

const int chipSelect = 10;

File dataFile;

char buf[30];

void PrintC(int year, int month, int day, int hours, int minutes, int seconds, float temp, bool C){

  int n = sprintf(buf, "%03d.%01d", (int)temp, (int)(temp*10)%10);
  
  if (C){
    n += sprintf(buf + n, "°C");
  }
  
  sprintf(buf + n, " %02d:%02d:%02d %02d/%02d/%04d", hours, minutes, seconds, day, month, year); 
}
void setup() { 
  Serial.begin(9600);

  pinMode(vccPin, OUTPUT); digitalWrite(vccPin, HIGH);
  pinMode(gndPin, OUTPUT); digitalWrite(gndPin, LOW);
  
  // Wait for MAX chip to stabilize
  delay(500);

  RTC.begin();
   
  lcd.begin();
  lcd.createChar(0, degree);

  while (!Serial) {
    ;
  }
  
  if (SD.begin(chipSelect)) {
    Serial.println("SD card initialized");
    dataFile = SD.open("datalog.txt", FILE_WRITE);
    
    if (!dataFile){
      Serial.println("Open datalog.txt error");
    }
  }        
  else{
    Serial.println("SD card initialization error, recording will not be performed");
  }
}

void loop() { 
  int year, month, day, hours, minutes, seconds;
  do { 
    year = RTC.getYear();
    month = RTC.getMonth();
    day = RTC.getDay();
    hours = RTC.getHours();
    minutes = RTC.getMinutes();
    seconds = RTC.getSeconds();
  }   
  while (RTC.getMinutes() != minutes);

  float temp = thermocouple.readCelsius();

  lcd.setCursor(0,0);
  sprintf(buf, "%02d/%02d/%04d", day, month, year);
  lcd.print(buf);
  lcd.setCursor(0,1);
  sprintf(buf, "%03d.%01d", (int)temp, (int)(temp*10)%10);
  lcd.print(buf);
  lcd.setCursor(5,1);
  lcd.print(char(0));
  lcd.print("C");
  lcd.setCursor(8,1);
  sprintf(buf, "%02d:%02d:%02d", hours, minutes, seconds);
  lcd.print(buf);

  PrintC(year, month, day, hours, minutes, seconds, temp, true);
  Serial.write(buf);

  if (dataFile) {
    
    PrintC(year, month, day, hours, minutes, seconds, temp, false);
    
    if (dataFile.write(buf) <= 0) {
      Serial.println("SD card write error");
      lcd.setCursor(11,0);
      lcd.print("ERROR");
    }
    dataFile.println();   
    if (++CounterSinceLastMeasure == IterationsBeforeFlush) {
      CounterSinceLastMeasure = 0;
      
      dataFile.flush();
      
      Serial.print(" Card flush completed");
      lcd.setCursor(14,0);
      lcd.print("SD"); 
    } 
  }

  Serial.println();
  
  delay(MeasurePeriod);

  lcd.setCursor(11,0);
  lcd.print("     ");
}
