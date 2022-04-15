bool judge(std::vector<unsigned int> a){
  int sr[10] = {0,1,2,3,4,5,6,7,8,9};
  for (int i = 0; i < 9; i++){
    if (sr[a[i]] == 0)
      return false;
    else
      sr[a[i]] = 0;
  }
  return true;
}
bool validSolution(unsigned int board[9][9]){
  int i, j;
  for (i = 0; i < 9; i++){
    std::vector<unsigned > tmp(board[i], board[i] + sizeof(board[i]) / sizeof(int));
    std::vector<unsigned > gg = {board[0][i], board[1][i], board[2][i],
                           board[3][i],board[4][i],board[5][i],
                          board[6][i],board[7][i],board[8][i]};
    if (!judge(tmp) || !judge(gg))
      return false;
  }
  for (i = 0; i < 3; i++){
    std::vector<unsigned > blo;
    for (j = 0; j < 3; j++){
      blo.push_back(board[3 * i][j]);
      blo.push_back(board[3 * i][j + 1]);
      blo.push_back(board[3 * i][j + 2]);
      blo.push_back(board[3 * i + 1][j]);
      blo.push_back(board[3 * i + 1][j + 1]);
      blo.push_back(board[3 * i + 1][j + 2]);
      blo.push_back(board[3 * i + 2][j]);
      blo.push_back(board[3 * i + 2][j + 1]);
      blo.push_back(board[3 * i + 2][j + 2]);
      if (!judge(blo))
        return false;
    }
  }
  return true;
}
