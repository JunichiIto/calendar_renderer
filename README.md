# CalendarRenderer

Sample implementation of http://yuji-shimoda.hatenablog.com/entry/2013/04/26/001951

## Usage

````
$ require './calendar_renderer'
$ puts CalendarRenderer.new(2013,1).render                                             
    January 2013
Su Mo Tu We Th Fr Sa
       1  2  3  4  5
 6  7  8  9 10 11 12
13 14 15 16 17 18 19
20 21 22 23 24 25 26
27 28 29 30 31
````

## How to test

````
$ rspec --color calendar_renderer_spec.rb
````
