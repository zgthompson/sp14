// Changes made by Zachary Thompson

#include "Set.hpp"
#include "SetScore.hpp"
#include "Game.hpp"
#include "TieBreaker.hpp"

Set::Set( Player *p1, Player *p2 ): Competition( p1, p2 ) {}
Score *Set::play( Player *p ) {

    Score* score = new SetScore( player1(), player2() );
    int gameCount = 0;

    while ( !score -> haveAWinner() ) {

        Player* server = ++gameCount % 2 == 1 ? p : Player::otherPlayer(p);

        if ( ((SetScore*) score) -> shouldPlayATieBreaker() ) {
            TieBreaker* tb = new TieBreaker( player1(), player2() );
            ((SetScore*) score) -> addTieScore( (TieBreakerScore*) tb -> play( server ) );
            delete tb;
        }
        else {
            Game* game = new Game( player1(), player2() );
            score -> addScore( (game -> play( server )) -> getWinner() );
            delete game;
        }
    }

    return score;
}

