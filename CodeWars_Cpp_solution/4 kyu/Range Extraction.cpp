#include <string>
#include <vector>

std::string range_extraction(std::vector<int> args) {
  std::string ans = "";
  int i, a, b, len;
  for (i = 0, a = b = -1, len = args.size(); i < len; i++){
    if (a == -1)
      a = b = i;
    else if (args[b] + 1 == args[i])
      b = i;
    else{
      if (args[b] - args[a] >= 2){
        ans += std::to_string(args[a]);
        ans += "-";
        ans += std::to_string(args[b]);
        ans += ",";
      }
      else if (a != b){
        ans += std::to_string(args[a]);
        ans += ",";
        ans += std::to_string(args[b]);
        ans += ",";
      }
      else{
        ans += std::to_string(args[a]);
        ans += ",";
      }
      a = b = i;
    }
  }
  if (args[b] - args[a] >= 2){
    ans += std::to_string(args[a]);
    ans += "-";
    ans += std::to_string(args[b]);
  }
  else if (a != b){
    ans += std::to_string(args[a]);
    ans += ",";
    ans += std::to_string(args[b]);
  }
  else{
    ans += std::to_string(args[a]);
  }
  
  return ans;
}