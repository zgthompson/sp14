// Changes made by Zachary Thompson

#include "TieBreaker.hpp"
#include "TieBreakerScore.hpp"
#include "PointScore.hpp"
#include "Player.hpp"

TieBreaker::TieBreaker( Player *p1, Player *p2 ): Competition( p1, p2 ) {}
Score *TieBreaker::play( Player *p ) {
    Score *score = new TieBreakerScore( player1(), player2() );
    Player* server = p;
    int serveCount = 0;

    while ( !score -> haveAWinner() ) {
        PointScore *pointScore = reinterpret_cast<PointScore *>( server->serveAPoint() );
        score->addScore( pointScore->getWinner() );
        delete pointScore;
        server = serveCount++ % 4 <  2 ? Player::otherPlayer(p) : p;
    }

    return score;
}

