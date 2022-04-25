#include <string>
#include <vector>

class SumOfDivided
{
public:
    static std::string sumOfDivided(std::vector<int> &lst) {
      if (lst.size() == 0)
        return "";
      std::string ans = "";
      std::vector<int> small_prime = {2, 3, 5, 7, 11, 13, 17, 19,
                                 23, 29, 31, 37, 41, 43, 47};
      int i, len, sum, max, flag;
      sum = flag = 0;
      max = lst[0];
      for (auto j : lst) {
        if (j % 2 == 0){
          sum += j;
        }
        if (abs(j) > max)
          max = abs(j);
      }
      if (sum) {
        ans += "(2 ";
        ans += std::to_string(sum);
        ans += ")";
      }
      for (sum = small_prime.back() + 2; sum <= max; sum += 2){
          len = 0;
          for (auto jj : small_prime)
            if (sum % jj == 0){
              len = 1;
              break;
            }
          if (len)
            continue;
          else{
            small_prime.push_back(sum);
          }
        
      }
      for (i = 1, len = small_prime.size(); i < len; i++){
        sum = flag = 0;
        for (auto j : lst) {
          if (j % small_prime[i] == 0){
            sum += j;
            flag = 1;
          }
        }
        
        if (flag){
          ans += "(";
          ans += std::to_string(small_prime[i]);
          ans += " ";
          ans += std::to_string(sum);
          ans += ")";
        }
      }
      
      return ans;
    }
};
