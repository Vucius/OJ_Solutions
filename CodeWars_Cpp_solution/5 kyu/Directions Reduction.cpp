class DirReduction
{
public:
    static std::vector<std::string> dirReduc(std::vector<std::string> &arr){
      int i, len;
      for (i = 0, len = arr.size() - 1; i < len; ){
        if (arr[i] == "EAST"){
          if (arr[i + 1] == "WEST"){
            arr.erase(arr.begin() + i, arr.begin() + i + 2);
            len -= 2;
            if (i > 0)
              i--;
            continue;
          }
        }
        else if (arr[i] == "SOUTH"){
          if (arr[i + 1] == "NORTH"){
            arr.erase(arr.begin() + i, arr.begin() + i + 2);
            len -= 2;
            if (i > 0)
              i--;
            continue;
          }
        }
        else if (arr[i] == "WEST"){
          if (arr[i + 1] == "EAST"){
            arr.erase(arr.begin() + i, arr.begin() + i + 2);
            len -= 2;
            if (i > 0)
              i--;
            continue;
          }
        }
        else if (arr[i] == "NORTH"){
          if (arr[i + 1] == "SOUTH"){
            arr.erase(arr.begin() + i, arr.begin() + i + 2);
            len -= 2;
            if (i > 0)
              i--;
            continue;
          }
        }
        i++;
      }
      return arr;
    }
};
