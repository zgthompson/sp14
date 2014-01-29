// Changes made by Zachary Thompson

#include "Match.hpp"
#include "MatchScore.hpp"
#include "Set.hpp"
#include "Player.hpp"

Match::Match( Player *p1, Player *p2 ): Competition( p1, p2 ) {}
Score *Match::play( Player *p ) {

    Score* score = new MatchScore( player1(), player2() );
    int setCount = 0;

    while ( !score->haveAWinner() ) {
        Set* set = new Set( player1(), player2() );
        Player* server = ++setCount % 2 == 1 ? p : Player::otherPlayer(p);
        ((MatchScore*) score) -> addScore( set -> play( server  ) );
        delete set;
    }

    return score;
}
