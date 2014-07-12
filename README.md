iOS-Serial-Terminal
===================

iOS sample app to demonstrate the usage of the Redpark TTL cable.

## Overview

1. [System requirements](README.md#system-requirements)
2. [Dependencies](README.md#dependencies)
3. [Talking to Arduino](README.md#talking-to-arduino)
4. [Credits / Acknowledgements](README.md#credits--acknowledgements)
5. [License](README.md#license)

## System requirements

iOS 7.0+

## Dependencies

iOS-Serial-Terminal uses [Redpark's TTL cable](http://redpark.com/ttl-serial-cable-c2-ttl/) to connect to Arduino. After cloning the repository please download the [Redpark SDK](http://redpark.com/developers/) and create the following folders inside the iOS-Serial-Terminal folder and copy the corresponding folder from the Redpark SDK. 

```
Redpark SDK/inc
Redpark SDK/lib
```

## Talking to Arduino

```c++
#include <SoftwareSerial.h>

static const int CABLE_BAUD_RATE = 9600;
static const int SERIAL_BAUD_RATE = 57600;

static const int RX_PIN = 4;
static const int TX_PIN = 5;

SoftwareSerial softSerial(RX_PIN,TX_PIN);

void setup()
{
  Serial.begin(SERIAL_BAUD_RATE);
  softSerial.begin(CABLE_BAUD_RATE);
}

void loop()
{
  while(softSerial.available())
  {
    Serial.write(softSerial.read());
  }
  
  while(Serial.available())
  {
    softSerial.write(Serial.read());
  }
}
```

## Credits / Acknowledgements

This project uses [Redpark's SDK](http://redpark.com/developers/).

## License

The MIT License (MIT)

Copyright (c) 2014 Jens Meder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
