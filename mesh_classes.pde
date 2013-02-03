class StateMesh {
  String lines[];
  float[][] v;
  int[][] f;
  float[][][] fd;

  StateMesh(String filename) {
    println("loading file");
    lines = loadStrings(filename);
    v = new float[0][0];
    f = new int[0][0];
    fd = new float[0][4][3];

    for (int i=0; i<lines.length; i++) {
      //println(lines[i]);
      String[] l = splitTokens(lines[i], " /");
      if (l.length > 1) {
        if (l[0].equals("v")) { //vertices;
          float[] pt = {
            float(l[1])*25.4, float(l[2])*25.4, float(l[3])*25.4
          };
          v = (float[][]) expand(v, v.length+1);
          v[v.length-1]= pt;
        }
        if (l[0].equals("f")) {
          //doing quads
          int[] f1;
          if (l.length>10) {
          int[] tf1 = {
            int(l[1]), int(l[4]), int(l[7]), int(l[10])
          };
          f1 = tf1;
          } else {
            int[] tf2 = {
            int(l[1]), int(l[4]), int(l[7]), int(l[7])
          };
          f1 = tf2;
          }
          f = (int[][]) expand(f, f.length+1);
          fd = (float[][][])expand(fd,fd.length+1);
          f[f.length-1] = f1;
          float[][] this_fd = new float[4][3];
          this_fd[0] = v[f1[0]-1];
          this_fd[1] = v[f1[1]-1];
          this_fd[2] = v[f1[2]-1];
          this_fd[3] = v[f1[3]-1];
          fd[fd.length-1] = this_fd;
        }
      }
    }
    String export=join(lines, "/");
    println(filename);
    println("face count");
    println(f.length);
    println("vertex count");
    println(v.length);
  }

  StateMesh(float[][][] _fd) {
    fd = _fd;
  }
}


class TweenMesh {
  int type = 0;
  StateMesh mesh1, mesh2;
  TweenMesh twmesh1, twmesh2;
  
  StateMesh currState;

  float[][][] facedata1, facedata2;
  
  float tween_val = 0.0;


  TweenMesh(String file1, String file2) {
    mesh1 = new StateMesh(file1);
    mesh2 = new StateMesh(file2);

    facedata1=mesh1.fd;
    facedata2=mesh2.fd;
    
    currState = getState();
  }

  TweenMesh(StateMesh A, StateMesh B) {
    mesh1 = A;
    mesh2 = B;

    facedata1=mesh1.fd;
    facedata2=mesh2.fd;
    
    currState = getState();
  }
  
  TweenMesh(TweenMesh A, TweenMesh B) {
    type = 1;
    twmesh1 = A;
    twmesh2 = B;

    facedata1=twmesh1.currState.fd;
    facedata2=twmesh2.currState.fd;
    
    currState = getState();
  }
  
  void setVal(float val) {
   if (type == 1) {
    facedata1=twmesh1.currState.fd;
    facedata2=twmesh2.currState.fd;
   }
   tween_val = val;
   updateState(); 
  }
  
  void updateOnly() {
   if (type == 1) {
    facedata1=twmesh1.currState.fd;
    facedata2=twmesh2.currState.fd;
   }
   updateState(); 
  }

  void render() {

    for (int i=0; i<facedata1.length; i++) {

      float[] a1 = facedata1[i][0];
      float[] b1 = facedata1[i][1];
      float[] c1 = facedata1[i][2];
      float[] d1 = facedata1[i][3];

      float[] a2 = facedata2[i][0];
      float[] b2 = facedata2[i][1];
      float[] c2 = facedata2[i][2];
      float[] d2 = facedata2[i][3];

      float[] a = getTween(a1, a2, tween_val);
      float[] b = getTween(b1, b2, tween_val);
      float[] c = getTween(c1, c2, tween_val);
      float[] d = getTween(d1, d2, tween_val);

      beginShape(QUADS);
      vertex(a[0], a[1], a[2]);
      vertex(b[0], b[1], b[2]);
      vertex(c[0], c[1], c[2]);
      vertex(d[0], d[1], d[2]);

      endShape();
    }
  }
  
  void save(String name) {
    int w = 72*60;
    int h = 72*70;
    PGraphics pdf = createGraphics(w, h, PDF, name+".pdf");
    pdf.beginDraw();
    for (int i=0; i<facedata1.length; i++) {

      float[] a1 = facedata1[i][0];
      float[] b1 = facedata1[i][1];
      float[] c1 = facedata1[i][2];
      float[] d1 = facedata1[i][3];

      float[] a2 = facedata2[i][0];
      float[] b2 = facedata2[i][1];
      float[] c2 = facedata2[i][2];
      float[] d2 = facedata2[i][3];

      float[] a = getTween(a1, a2, tween_val);
      float[] b = getTween(b1, b2, tween_val);
      float[] c = getTween(c1, c2, tween_val);
      float[] d = getTween(d1, d2, tween_val);

      pdf.beginShape(QUADS);
      pdf.vertex(a[0]*2.83464567, h-a[1]*2.83464567);
      pdf.vertex(b[0]*2.83464567, h-b[1]*2.83464567);
      pdf.vertex(c[0]*2.83464567, h-c[1]*2.83464567);
      pdf.vertex(d[0]*2.83464567, h-d[1]*2.83464567);

      pdf.endShape();
    }
    pdf.dispose();
    pdf.endDraw();
  }

  StateMesh getState() {
    int cnt = min(facedata1.length,facedata2.length);
    float[][][] fd = new float[cnt][4][3];
    for (int i=0; i<cnt; i++) {
      fd[i][0] = getTween(facedata1[i][0], facedata2[i][0], tween_val);
      fd[i][1] = getTween(facedata1[i][1], facedata2[i][1], tween_val);
      fd[i][2] = getTween(facedata1[i][2], facedata2[i][2], tween_val);
      fd[i][3] = getTween(facedata1[i][3], facedata2[i][3], tween_val);
      
      //println(vertices[i]);
    }

    StateMesh mesh = new StateMesh(fd);
    return mesh;
  }
  
  void updateState() {
    int cnt = min(facedata1.length,facedata2.length);
    float[][][] fd = new float[cnt][4][3];
    for (int i=0; i<cnt; i++) {
      fd[i][0] = getTween(facedata1[i][0], facedata2[i][0], tween_val);
      fd[i][1] = getTween(facedata1[i][1], facedata2[i][1], tween_val);
      fd[i][2] = getTween(facedata1[i][2], facedata2[i][2], tween_val);
      fd[i][3] = getTween(facedata1[i][3], facedata2[i][3], tween_val);
      
      //println(vertices[i]);
    }

    currState.fd = fd;
  }
}

Vec3D getTween(Vec3D v1, Vec3D v2, float n) {
  //Vec3D v = v1.sub(v2);
  //return v1.add(v.scale(n));

  float x = (v2.x-v1.x)*n;
  float y = (v2.y-v1.y)*n;
  float z = (v2.z-v1.z)*n;

  return new Vec3D(x, y, z);
}

float[] getTween(float[] v1, float[] v2, float n) {
  float[] pt = new float[3];

  pt[0] = v1[0]+(v2[0]-v1[0])*n;
  pt[1] = v1[1]+(v2[1]-v1[1])*n;
  pt[2] = v1[2]+(v2[2]-v1[2])*n;

  return pt;
}

