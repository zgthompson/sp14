// Changes made by Zachary Thompson

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include "SetScore.hpp"

SetScore::SetScore( Player *p1, Player *p2 ): Score(p1, p2), tieScore(0) {}
  
bool SetScore::haveAWinner() { 
    return ( ((p1Score >= 6 || p2Score >= 6) && abs(p1Score - p2Score) >= 2) ||
            tieScore != NULL );
}
bool SetScore::shouldPlayATieBreaker() { 
    return p1Score == 6 && p2Score == 6;
}

void SetScore::addTieScore( TieBreakerScore *score ) {
    addScore( score->getWinner() );
    this->tieScore = score;
}

void SetScore::print() {
    std::cout << std::setw(10) << player1Score() << std::setw(18) << player2Score();
    if( tieScore != NULL )
      tieScore->print();
    std::cout << std::endl;
}
