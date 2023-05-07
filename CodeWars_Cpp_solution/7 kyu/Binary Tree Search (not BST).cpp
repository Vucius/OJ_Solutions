struct Node{
  int val;
  Node *left = nullptr;
  Node *right = nullptr;
};

bool search(int n, Node *root){
  if (!root)
    return false;
  std::vector<Node*> tmp = {root};
  int i, len;
  for (i = 0, len = 1; i < len; i++) {
    if (tmp[i]->val == n)
      return true;
    if (tmp[i]->left){
      tmp.push_back(tmp[i]->left);
      len++;
    }
    if (tmp[i]->right){
      tmp.push_back(tmp[i]->right);
      len++;
    }
  }
  return false;
}
/*if (root->val == n)
    return true;
  if (root->left && root->right)
    return search(n, root->left) || search(n, root->right);
  else if (root->left)
    return search(n, root->left);
  else if (root->right)
    return search(n, root->right);
  else
    return false;*/