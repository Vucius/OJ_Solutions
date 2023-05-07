#include <cstdint>
#include <string>
std::string add_binary(uint64_t a, uint64_t b) {
  uint64_t c = a + b;
  if (!c)
    return "0";
  
  std::string tmp = "";
  while (c){
    tmp = std::to_string(c % 2) + tmp;
    c >>= 1;
  }
  return tmp;
}