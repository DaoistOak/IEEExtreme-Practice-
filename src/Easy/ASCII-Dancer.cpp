#include <iostream>
#include <string>
#include <vector>

using namespace std;

vector<string> man = {" o ", "/|\\", "/ \\"};
bool front = true;

void print() {
  for (string row : man) {
    if (front) {
      cout << row << "\n";
    } else {
      string out = "";
      for (int i = 2; i >= 0; i--) {
        char c = row[i];
        if (c == '/')
          c = '\\';
        else if (c == '\\')
          c = '/';
        else if (c == '<')
          c = '>';
        else if (c == '>')
          c = '<';
        else if (c == '(')
          c = ')';
        else if (c == ')')
          c = '(';
        out += c;
      }
      cout << out << "\n";
    }
  }
  cout << flush;
}

int main() {
  string line;
  print(); // starting position

  while (getline(cin, line)) {
    if (line.empty())
      continue;

    if (line.rfind("say ", 0) == 0) {
      cout << line.substr(4) << "\n" << flush;
      continue;
    }

    if (line == "left hand to head") {
      man[0][0] = '(';
      man[1][0] = ' ';
    } else if (line == "left hand to hip") {
      man[0][0] = ' ';
      man[1][0] = '<';
    } else if (line == "left hand to start") {
      man[0][0] = ' ';
      man[1][0] = '/';
    } else if (line == "right hand to head") {
      man[0][2] = ')';
      man[1][2] = ' ';
    } else if (line == "right hand to hip") {
      man[0][2] = ' ';
      man[1][2] = '>';
    } else if (line == "right hand to start") {
      man[0][2] = ' ';
      man[1][2] = '\\';
    } else if (line == "left leg in") {
      man[2][0] = '<';
    } else if (line == "left leg out") {
      man[2][0] = '/';
    } else if (line == "right leg in") {
      man[2][2] = '>';
    } else if (line == "right leg out") {
      man[2][2] = '\\';
    } else if (line == "turn") {
      front = !front;
    } else {
      cerr << "unknown command: " << line << "\n";
      continue;
    }

    print();
  }
  return 0;
}
