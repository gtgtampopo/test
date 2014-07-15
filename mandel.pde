import java.util.*;

Utils ut = null;
Vector<Float> ptz = null, ptc = null;

void setup(){
  size(800, 800);
  ptz = new Vector();
  ptc = new Vector();
  ptz.add(1.0f);ptz.add(1.0f);ptz.add(1.0f);
  ptc.add(1.0f);ptc.add(1.0f);ptc.add(1.0f);
  ut = new Utils(width, height, -2.0, 2.0, 2.0, -2.0);
  colorMode(HSB, 1,1,1);
  //test comment
}

void mouseClicked(){
    PVector mp = ut.getPos(mouseX, mouseY);
    if(mouseButton==LEFT){
      ut.zoom *= 0.8f;
      ut.pl = mp.x - ut.zoom;
      ut.pr = mp.x + ut.zoom;
      ut.pt = mp.y + ut.zoom;
      ut.pb = mp.y - ut.zoom;
    }else{
      ut.zoom *= 1.2f;
      ut.pl = mp.x - ut.zoom;
      ut.pr = mp.x + ut.zoom;
      ut.pt = mp.y + ut.zoom;
      ut.pb = mp.y - ut.zoom;
    }
}

void draw(){
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      PVector p = ut.getPos(x,y);
      int m = ut.calcMandel(p.x,p.y,200);
      float l = (float)m/200.0f;
      if(m==0){
        set(x,y,color(0,0,0));
      }else{
        set(x,y,color(1,1,5.0*l));
        
      }
    }
  }
}

class Utils {
  public float dw,dh,pl,pt,pr,pb,zoom;
  public Utils(float dw,float dh,float pl,float pt,float pr,float pb){
    this.dw = dw;
    this.dh = dh;
    this.pl = pl;
    this.pt = pt;
    this.pr = pr;
    this.pb = pb;
    zoom = (pr-pl)/2.0f;
  }
  public PVector getDisplayPos(float px, float py){
    return new PVector(dw*(px-pl)/(pr-pl), dh*(py-pb)/(pt-pb));
  }
  public PVector getPos(int xi, int yi){
    float x=xi,y=yi;
    return new PVector(x/dw*(pr-pl)+pl, y/dh*(pt-pb)+pb);
  }
  public int calcMandel(float ire, float iim, int n){
    float tre,tim;
    //float nire = ire, niim = iim;
    //float nire = ire/(ire*ire+iim*iim), niim = -iim/(ire*ire+iim*iim);
    float nire = (ire*ire - iim*iim)/pow(ire*ire+iim*iim, 2), niim = -2.0*ire*iim/pow(ire*ire+iim*iim,2);
    //float nire = ire, niim = iim;
    
    float cre = nire, cim = niim;
    for(int i=0;i<n;i++){
      //int iptz = i%ptz.size();
      //int iptc = i%ptc.size();
      //tre = ptz.get(iptz)*(cre*cre - cim*cim) + ptc.get(iptc)*ire;
      //tim = ptz.get(iptz)*2.0*cre*cim + ptc.get(iptc)*iim;
      //float a=3.0;
      //tre = a*(cre*cre - cim*cim + ire) + (1.0-a)*cre;
      //tim = a*(2*cre*cim + iim) + (1.0-a)*cim;
      //cre = tre;
      //cim = tim;
      tre = cre*cre - cim*cim + nire;
      tim = 2.0*cre*cim + niim;
      cre = tre;
      cim = tim;
      if(cre*cre + cim*cim > 4.0)return i+1;
    }
    return 0;
  }
}
