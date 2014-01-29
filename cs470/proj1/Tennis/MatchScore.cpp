// Changes made by Zachary Thompson

#include "MatchScore.hpp"
#include <iostream>
#include <iomanip>

MatchScore::MatchScore( Player *p1, Player *p2 ): Score( p1, p2 ), setNumber(0) {}
bool MatchScore::haveAWinner()  { 
    return (p1Score == 3 || p2Score == 3);
}
void MatchScore::addScore( Score *score ) {
    Score::addScore( score -> getWinner() );
    scores[setNumber++] = (SetScore*) score;
}

void MatchScore::print() {
    std::cout << "   Set No.    Player A          Player B\n";  
    for( int i = 0; i < setNumber; i++ ) {
        std::cout << std::setw(7) << i+1;
        scores[i]->print();
    }
    char winner;
    int winScore;
    int loseScore;

    if (p1Score > p2Score) {
        winner = 'A';
        winScore = p1Score;
        loseScore = p2Score;
    }
    else {
        winner = 'B';
        winScore = p2Score;
        loseScore = p1Score;
    }

    std::cout << std::endl;
    std::cout << "Player " << winner  << " wins the match " << winScore
        << " sets to " << loseScore << std::endl;
}
MatchScore::~MatchScore() {
    for( int i = 0; i < setNumber; i++ )
      delete scores[i];
}
