xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method 'xml';
declare option output:indent 'yes';

transform(
  map {
    'source-node' : doc('items-with-child-elements.xml'),
    'stylesheet-location' : 'child-elements-to-attributes.xsl'
  }
)?output 
! 
transform (map {
  'initial-match-selection' : .,
  'stylesheet-location' : 'streamed-grouping.xsl'
})?output