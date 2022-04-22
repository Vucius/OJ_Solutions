class RGBToHex
{
  public:
  static std::string rgb(int r, int g, int b){
    char hhh[16] = {'0', '1', '2', '3',
                    '4', '5', '6', '7',
                    '8', '9', 'A', 'B',
                    'C', 'D', 'E', 'F'};
    if (r < 0)
      r = 0;
    if (r > 255)
      r = 255;
    if (g < 0)
      g = 0;
    if (g > 255)
      g = 255;
    if (b < 0)
      b = 0;
    if (b > 255)
      b = 255;
    std::string ans = "";
    ans += hhh[r / 16];
    ans += hhh[r % 16];
    ans += hhh[g / 16];
    ans += hhh[g % 16];
    ans += hhh[b / 16];
    ans += hhh[b % 16];
    return ans;
  }
};
