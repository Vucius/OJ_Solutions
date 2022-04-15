namespace Triangle
{
  bool isTriangle(int a, int b, int c)
  {
    if (a < 0 || b < 0 || c < 0)
      return false;
    long aa, bb, cc;
    aa = a;
    bb = b;
    cc = c;
    if (aa >= bb && aa >= cc)
      return (bb + cc > aa);
    else if (bb >= aa && bb >= cc)
      return (aa + cc > bb);
    else
      return (aa + bb > cc);
  }
};