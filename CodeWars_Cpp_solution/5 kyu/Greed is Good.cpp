#include <vector>

int score(const std::vector<int>& dice) {
  int cc[7] = {0, 0, 0, 0, 0, 0, 0};
  for (auto d : dice)
    cc[d] += 1;
  if (cc[1] >= 3)
    cc[0] += 1000;
  if (cc[5] >= 3)
    cc[0] += 500;
  cc[0] += (cc[1] % 3) * 100;
  cc[0] += (cc[5] % 3) * 50;
  cc[1] = 5 - cc[1] - cc[5];
  if (cc[1] < 3)
    return cc[0];
  for (int i = 2; cc[1] > 2; cc[1] -= cc[i], i++){
    if (cc[i] >= 3) {
      cc[0] += i * 100;
      return cc[0];
    }
  }
  if (cc[1] > 2)
    cc[0] += 600;
  return cc[0];
}