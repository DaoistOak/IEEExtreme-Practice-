#include <iostream>
#include <vector>

using namespace std;

int c[1000000];
int main() {
  int cities, total_miles;
  cin >> cities >> total_miles;
  for (int i = 1; i < cities; i++) {
    cin >> c[i];
  }
  int queries;
  cin >> queries;

  vector<bool> dp(total_miles + 1, false);
  dp[0] = true;
  for (int i = 1; i < cities; i++) {
    int cost = 2 * c[i];
    for (int current_miles = cost; current_miles <= total_miles;
         ++current_miles) {
      if (dp[current_miles - cost]) {
        dp[current_miles] = true;
      }
    }
  }
  while (queries--) {
    int start, dest;
    cin >> start >> dest;
    int leftover = total_miles - (c[dest] + c[start]);
    if (leftover >= 0 && dp[leftover]) {
      cout << "YES\n";
    } else {
      cout << "NO\n";
    }
  }

  return 0;
}
