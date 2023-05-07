std::string likes(const std::vector<std::string> &names)
{
  std::string ans = "";
  int len = names.size();
  switch (len) {
      case 0:
        ans = "no one likes this";
        break;
      case 1:
        ans = names[0] + " likes this";
        break;
      case 2:
        ans = names[0] + " and " + names[1] + " like this";
        break;
      case 3:
        ans = names[0] + ", " + names[1] + " and " + names[2] + " like this";
        break;
      default:
        ans = names[0] + ", " + names[1] + " and "+ std::to_string(len - 2) + " others like this";
        break;
  }
  return ans; // Do your magic!
}