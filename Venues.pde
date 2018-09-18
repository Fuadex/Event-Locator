class Venue {

  float lon;
  float lat;
  float data;
  SimplePointMarker marker;
  float x;
  float y;
  ArrayList<Artist> artistList = new ArrayList<Artist>();
  boolean isClosest = false;

  public Venue(float lat, float lon) {
    this.lon = lon;
    this.lat = lat;

    Location Loc = new Location(lat, lon);

    this.marker = new SimplePointMarker(Loc);
  }

  void draw() { //Depending on what's found, the map will get drawn based on the following stylings
    ScreenPosition PosPos = this.marker.getScreenPosition(map);

    if (artistList.get(0).listen == true) { //Search by last.fm matched artists'
      ifif(PosPos);
    }

    if (!artistList.get(0).listen) {
      standard(PosPos);
    }

    if (!(selecttag == null) && artistList.get(0).tag.contains(selecttag)) { //Search by the inputted genre tags
      ifif(PosPos);
    }

    if (!(selectartist == null) && artistList.get(0).name.contains(selectartist)) { //Search the the inputted artist's name
      ifif(PosPos);
    }
  }

  //Redirects to specific styles based on the found tags

  void ifif (ScreenPosition PosPos) {
    hoveroption(PosPos);
    if (artistList.get(0).tag.contains("indie")) { 
      indie(PosPos);
    } else if (artistList.get(0).tag.contains("pop")) { 
      pop(PosPos);
    } else if (artistList.get(0).tag.contains("metal")) { 
      metal(PosPos);
    } else if (artistList.get(0).tag.contains("electronic")) { 
      electronic(PosPos);
    } else if (artistList.get(0).tag.contains("reggae")) { 
      reggae(PosPos);
    } else if (artistList.get(0).tag.contains("jazz")) { 
      jazz(PosPos);
    } else if (artistList.get(0).tag.contains("Hip-Hop")) { 
      hiphop(PosPos);
    } else if (artistList.get(0).tag.contains("country")) { 
      country(PosPos);
    } else if (artistList.get(0).tag.contains("dubstep")) { 
      dubstep(PosPos);
    } else if (artistList.get(0).tag.contains("folk")) { 
      folk(PosPos);
    } else if (artistList.get(0).tag.contains("punk")) { 
      punk(PosPos);
    } else if (artistList.get(0).tag.contains("Classic")) { 
      classic(PosPos);
    } else if (artistList.get(0).tag.contains("core")) { 
      core(PosPos);
    } else if (artistList.get(0).tag.contains("rock")) { 
      rock(PosPos);
    } else if (artistList.get(0).tag.contains("progressive")) { 
      progressive(PosPos);
    } else {
      standard(PosPos);
    }
  }

  //The following are the stylings created for the sole purpose of distinguishing between genres

  void indie(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(255, 255, 255);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void rock(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(185, 85, 0);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void pop(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(255, 83, 255);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void metal(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(0, 0, 0, 200);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void electronic(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(0, 255, 0, 200);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void reggae(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(255, 100, 100, 200);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void jazz(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(150, 150, 150);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void hiphop(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(0, 200, 255);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void country(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(50, 100, 0);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void dubstep(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(255, 255, 0);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void folk(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(100, 0, 50);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void punk(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(255, 0, 0);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void classic(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(0, 0, 0);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void progressive(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(0, 100, 150);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }
  void core(ScreenPosition PosPos) {
    strokeWeight(5);
    stroke(255, 100, 0);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8);
    ellipse(PosPos.x, PosPos.y, 3, 3);
    hoveroption(PosPos);
  }

  //This is the standard venue locator styling

  void standard(ScreenPosition PosPos) {
    if (mouseX>PosPos.x-18*artistList.size() && mouseX<PosPos.x+18*artistList.size() && mouseY>PosPos.y-18*artistList.size() && mouseY<PosPos.y+18*artistList.size())
      if (isClosest == true)
      {
        textSize(20);
        text (artistList.get(0).name, PosPos.x-25, PosPos.y-artistList.size()*20-50);
      }
    int zoomlevel = map.getZoomLevel();
    strokeWeight(4);
    stroke(67, 211, 227, zoomlevel*8);
    noFill();
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), -PI * 0.8, -PI * 0.2);
    arc(PosPos.x, PosPos.y, 18*artistList.size(), 18*artistList.size(), PI * 0.2, PI * 0.8); //The arc size increases accordingly to the number of artists playing at a certain venue
  }

  // According to the mouse pointer's position, a window encompassing the venue's & artist's details will pop up

  void hoveroption(ScreenPosition PosPos) {
    int zoomlevel = map.getZoomLevel();
    strokeWeight(4);
    stroke(67, 211, 227, zoomlevel*10);

    if (isClosest == true)
    {

      if (zoomlevel > 4) {
        fill(0, 45, 90);
        rect(PosPos.x+100, PosPos.y-20, 350, 170);
        fill(255, 255, 255);
        textSize(20);
        text (" Artist", PosPos.x+130, PosPos.y);
        text ("  Genre", PosPos.x+130, PosPos.y+20);
        text ("Date", PosPos.x+130, PosPos.y+40);
        text ("Time", PosPos.x+130, PosPos.y+60);
        text ("  Venue", PosPos.x+130, PosPos.y+80);
        text ("      Address", PosPos.x+130, PosPos.y+100);
        text ("URL", PosPos.x+130, PosPos.y+130);
        text (artistList.get(0).name, PosPos.x+300, PosPos.y);
        text (artistList.get(0).tag, PosPos.x+300, PosPos.y+20);
        text (artistList.get(0).data.substring(0, 10), PosPos.x+300, PosPos.y+40);
        text (artistList.get(0).data.substring(11, 19), PosPos.x+300, PosPos.y+60);
        text (artistList.get(0).nam, PosPos.x+300, PosPos.y+80);
        text (artistList.get(0).add, PosPos.x+300, PosPos.y+100);
        urlOfClosestVenue=artistList.get(0).url;
        if (artistList.get(0).url == "") {
          text ("Nope :(", PosPos.x+300, PosPos.y+130); //If there is no url, then 'Nope :(' will be presented
        } else {
          text ("Press ENTER for INFO", PosPos.x+300, PosPos.y+130);
        }
      }
    }
  }
}