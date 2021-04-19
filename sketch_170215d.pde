import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;

import de.fhpotsdam.unfolding.providers.Microsoft;
import de.fhpotsdam.unfolding.providers.StamenMapProvider.WaterColor;
// Loads up the unfolding maps plugin

import controlP5.*;
// Loads up the controlP5 plugin

ControlP5 cp5;

String urlOfClosestVenue;


UnfoldingMap map;
SimplePointMarker Marker;

String text1="";
String txb1, txb2;
String selecttag;
String selectartist;

ArrayList<Venue> venuesList = new ArrayList<Venue>();
ArrayList<Tags> TagsList = new ArrayList<Tags>();


HashMap<String, String> artistTagMap;
HashMap<String, String> userMap;


StringBuffer sb = new StringBuffer();

void setup() {
  size(1920, 1080, OPENGL); //Rendering in OpenGL
  map = new UnfoldingMap(this, new Microsoft.AerialProvider()); // Choice of map, Microsoft.AerialProvider
  MapUtils.createDefaultEventDispatcher(this, map);

// Font Choice
  PFont font = loadFont("Arial-BoldMT-48.vlw");
  textFont(font, 24);
  textAlign(CENTER);

// Focuses on the area of North America
  Location american = new Location(38.8f, -97.8f);
  map.zoomAndPanTo(american, 5);
  float maxPanningDistance = 100000; // in km
  map.setPanningRestriction(american, maxPanningDistance);

// Loads up the files of already compared databases of downloaded jamBase artists and last.fm genres
  readArtistTagFile("artists_tags.csv");

// Loads up the databases downloaded from JamBase (limit of 50 requests per day forced us to save the xml files)
  readXML("events9411.xml");
  readXML("eventsny.xml");
  readXML("events9350.xml");
  readXML("events7500.xml");
  readXML("eventsMI.xml");
  readXML("eventsJA.xml");
  readXML("eventsAT.xml");
  readXML("eventsCGO.xml");
  readXML("events5540.xml");
  readXML("eventsBO.xml");
  readXML("eventsRM.xml");
  readXML("eventsSA.xml");
  readXML("eventsDN.xml");
  readXML("eventsLV.xml");
  readXML("eventsSLC.xml");
  readXML("eventsNV.xml");
  readXML("eventsKC.xml");
  readXML("eventsTU.xml");
  readXML("eventsNO.xml");
  readXML("eventsCI.xml");
  readXML("eventsSL.xml");
  readXML("eventsAT.xml");
  userlistenedto("Fuadex"); //directed string, which is used as a default username later on

// These are windows and buttons created for inputting text and submitting it, triggering a reaction
  cp5 = new ControlP5(this);
  cp5.addTextfield("TopArtists").setPosition(20, 20).setSize(100, 20).setAutoClear(false).setFont(createFont("bitfont", 20));
  cp5.addTextfield("Weekly").setPosition(165, 20).setSize(100, 20).setAutoClear(false).setFont(createFont("bitfont", 20));
  cp5.addTextfield("Genre").setPosition(325, 20).setSize(100, 20).setAutoClear(false).setFont(createFont("bitfont", 20));
  cp5.addTextfield("Artist").setPosition(470, 20).setSize(100, 20).setAutoClear(false).setFont(createFont("bitfont", 20));
  cp5.addBang("Sub1").setPosition(135, 20).setSize(20, 20).setLabel("").setFont(createFont("bitfont", 20)); 
  cp5.addBang("Sub2").setPosition(285, 20).setSize(20, 20).setLabel("").setFont(createFont("bitfont", 20)); 
  cp5.addBang("Sub3").setPosition(440, 20).setSize(20, 20).setLabel("").setFont(createFont("bitfont", 20)); 
  cp5.addBang("Sub4").setPosition(585, 20).setSize(20, 20).setLabel("").setFont(createFont("bitfont", 20)); 
  cp5.addBang("Sub5").setPosition(20, 80).setSize(80, 30).setLabel("CLEAR").setFont(createFont("bitfont", 20)); 

//This one will create a new file, in which assigned genres to artists will appear. Used only if a new JamBase xml file was downloaded.

  //PrintWriter out = createWriter("artists_tags.csv");
  //out.println(sb.toString());
  //out.flush();
  //out.close();
}

// Hashmap of each Artist and the genre belonging it each

void readArtistTagFile(String filename) {

  artistTagMap=new HashMap<String, String>();
  String[] lines = loadStrings(filename);
  for (int i =0; i<lines.length; i++) {
    String[] columns = splitTokens(lines[i], ";");
    if (columns.length > 1)
      artistTagMap.put(columns[0], columns[1]);
    else if (columns.length>0)
      artistTagMap.put(columns[0], "");
  }
}

//Loads up selective details from the xml files, such as: latitude and longitude, address, url etc.

void readXML(String filename) {


  XML xml = loadXML(filename);
  XML[] Events_node = xml.getChildren("Events");

  for (int i=0; i < Events_node.length; i++) {
    println(i);
    XML Venue = Events_node[i].getChildren("Venue")[0];
    XML Latitude = Venue.getChildren("Latitude")[0];
    XML Longtitude = Venue.getChildren("Longitude")[0];
    XML NameE = Venue.getChildren("Name")[0];
    XML Address = Venue.getChildren("Address")[0];
    XML URL = Venue.getChildren("Url")[0];

    float lat = float(Latitude.getContent());
    float lon = float(Longtitude.getContent());
    String nam = NameE.getContent();
    String add = Address.getContent();
    String url = URL.getContent();

    XML Data = Events_node[i].getChildren("Date")[0];
    String data = Data.getContent();

    //Read additional info of xml
    //pass and store more info in VenueObject through Constructor
    Venue va = new Venue(lat, lon);
    venuesList.add(va);


    XML artists = Events_node[i].getChildren("Artists")[0];
    XML[] artist = artists.getChildren("Artist");
    for (int j=0; j < artist.length; j++) {
      XML name1 = artist[j].getChildren("Name")[0];
      String art_name = name1.getContent();
      String tag = artistTagMap.get(art_name).toLowerCase();//readXMLlastfm(art_name); // The grayed out one here and below helps dump the new artists_tags file
      //sb.append(art_name + ";" + tag + "\n");


      Artist art = new Artist(art_name, tag, data, nam, add, url); //stores the drawn data from the xml file
      va.artistList.add(art);


      println(art_name + ", " + tag); //checks if the combination of artists' names and tags work (and prints it out)
    }
  }
}

void userlistenedto(String user) {

  user = user.replace(" ", "%20"); //error prevention

  userMap = new HashMap<String, String>(); //Hashmap of compared venues artists' playing against the listened artists on last.fm

  println("readXML: "+user);
  XML xml = null;

  try {
    xml = loadXML("http://ws.audioscrobbler.com/2.0/?method=user.getTopArtists&limit=100&api_key=GET_YOUR_OWN_API_BRO&user="+user); //loads a specific username xml file
  }
  catch(Exception e) {
  }

  XML topartists_node = xml.getChildren("topartists")[0]; //top artists from last.fm profile

  if (topartists_node.getChildren("artist").length > 0) {
    XML[] artist = topartists_node.getChildren("artist");
    for (int k=0; k < artist.length; k++) {
      XML name = artist[k].getChildren("name")[0];
      String userartist = name.getContent();
      println(userartist);
      userMap.put(userartist, "");
    }
  }
  for (int i=0; i < venuesList.size(); i++) { //artists from the stored venueslist
    ArrayList<Artist> artistList = venuesList.get(i).artistList;
    for (int z=0; z < artistList.size(); z++) {
      if (userMap.containsKey(artistList.get(z).name)) {
        artistList.get(z).listen = true;
      } else { 
        artistList.get(z).listen = false;
      }
    }
  }
}

void userlistenedtolastweek(String user) { //This is the same code as the previous one, the only difference is that it checks against last.fm's listened artists LAST WEEK

  user = user.replace(" ", "%20");

  userMap = new HashMap<String, String>();

  println("readXML: "+user);
  XML xml = null;

  try {
    xml = loadXML("http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyArtistChart&limit=100&api_key=GET_YOUR_OWN_API_BRO&user="+user);
  }
  catch(Exception e) {
  }

  XML weeklyartistchart_node = xml.getChildren("weeklyartistchart")[0];

  if (weeklyartistchart_node.getChildren("artist").length > 0) {
    XML[] artist = weeklyartistchart_node.getChildren("artist");
    for (int k=0; k < artist.length; k++) {
      XML name = artist[k].getChildren("name")[0];
      String userartist = name.getContent();
      println(userartist);
      userMap.put(userartist, "");
    }
  }
  for (int i=0; i < venuesList.size(); i++) {
    ArrayList<Artist> artistList = venuesList.get(i).artistList;
    for (int z=0; z < artistList.size(); z++) {
      if (userMap.containsKey(artistList.get(z).name)) {
        artistList.get(z).listen = true;
      } else { 
        artistList.get(z).listen = false;
      }
    }
  }
}

String readXMLlastfm(String artist) { //That one will get the top tags of selected artists on last.fm (although the first one is the important one)

  artist = artist.replace(" ", "%20");

  println("readXML: "+artist);
  XML xml = null;

  try {
    xml = loadXML("http://ws.audioscrobbler.com/2.0/?method=artist.getTopTags&limit=200&api_key=GET_YOUR_OWN_API_BRO&artist="+artist);
  }
  catch(Exception e) {
  }

  if (xml == null)
    return "";

  if (xml.getChildren("error").length > 0) {
    return "";
  }

  XML toptags_node = xml.getChildren("toptags")[0];

  if (toptags_node.getChildren("tag").length > 0) {
    XML tag = toptags_node.getChildren("tag")[0];
    XML name = tag.getChildren("name")[0];
    String tag_name = name.getContent();
    println(tag_name);
    return tag_name;
  }
  return "";
}



void draw() {
  map.draw(); //draws the map


/* The following code checks for the closest object to the mouse's pointer position
The object closest will have additional information presented right next to it*/
  Location geoLocationOfMouse = map.getLocation(mouseX, mouseY);
  Double minDistance = null;
  Venue venueWithMinDistance = null;
  for (int i=0; i < venuesList.size(); i++) {
    Venue venueToCheckDistance = venuesList.get(i);



    if (!(selecttag == null) && venueToCheckDistance.artistList.get(0).tag.contains(selecttag)
      || !(selectartist == null) && venueToCheckDistance.artistList.get(0).name.contains(selectartist)
      || venueToCheckDistance.artistList.get(0).listen == true) {

      venueToCheckDistance.isClosest = false;
      Location locationOfVenue = new Location(venueToCheckDistance.lat, venueToCheckDistance.lon);

      if (minDistance == null || minDistance > geoLocationOfMouse.getDistance(locationOfVenue)) {
        minDistance = geoLocationOfMouse.getDistance(locationOfVenue);
        venueWithMinDistance = venueToCheckDistance;
      }
    }
  }
  if (venueWithMinDistance != null) {
    venueWithMinDistance.isClosest = true;
  }

  for (int i=0; i < venuesList.size(); i++) {
    venuesList.get(i).draw();
  }

  if (text1.equals("abcd"))
    println("Hurra!");
}

// If enter is pressed, the url from the closest object (venue) will we launched in the web browser (provided there is an existing url)

void keyPressed() {
  text1+=key;
  println (text1);


  if (key == ENTER && urlOfClosestVenue != null && urlOfClosestVenue != "") {
    link(urlOfClosestVenue);
  }
}

// Colors the map accordingly to the style that gets called for in the Venues Class

void coloring() {
  for (int i=0; i < venuesList.size(); i++) {
    ScreenPosition PosPos = venuesList.get(i).marker.getScreenPosition(map);
    strokeWeight(16);
    stroke(67, 211, 227, 100);
    noFill();
    ellipse(PosPos.x, PosPos.y, 36, 36);
  }
}

//The following are text boxes operating on ControlP5

void Sub1() {
  print("search:");
  txb1 = cp5.get(Textfield.class, "TopArtists").getText();
  print(" TopArtists = " + txb1);
  userlistenedto(txb1);
  println();
}

void Sub2() {
  print("search:");
  txb2 = cp5.get(Textfield.class, "Weekly").getText();
  print(" WeeklyArtists = " + txb2);
  userlistenedtolastweek(txb2);
  println();
}

void Sub3() {
  print("search:");
  selecttag = cp5.get(Textfield.class, "Genre").getText();
  print(" Genre = " + selectartist);
  println();
}

void Sub4() {
  print("search:");
  selectartist = cp5.get(Textfield.class, "Artist").getText();
  print(" Artist = " + selectartist);
  println();
}

void Sub5() {
  txb1="Fuadex";
  userlistenedto(txb1);
  selecttag=null;
  selectartist=null;
}