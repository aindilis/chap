(here are some (weak) moral dilemmas, but nevertheless, perhaps
 worth formalizing: dhttp://www.quose.com/index.php)

(WTF
 chess.kbs
 ("implies" ("and" "true") ("different_square" ("square" var-X1 var-Y1) ("square" var-X2 var-Y2)))
 ("implies" ("and" "true") ("theoretical_range" ("piece" "black" "pawn") "move" ("square" var-X "7") ("square" var-X "5")))
 ("implies" ("and" "true") ("theoretical_range" ("piece" "white" "pawn") "move" ("square" var-X "2") ("square" var-X "4")))
 )

(should have a query about whether the position is theoretically
 reachable from the initial conditions of chess or any of its
 variants etc.)

(should include a usage of SuppositionalReasoner.  also should
 flag ethical violations, for instance - a piece has been
 taken...  should allow for annotation.  Should be able to work
 with various planning scenarios as well, such as the TPTP
 database and also the database of planning problems I have.
 Lastly, should have a library of ethical dilemnas, with theorems
 about them, annotations, etc, to allow us to review and reenact
 ethical situations and figure out what to do in each case, and
 then apply to the planner)

(http://www.chesscircle.net/forums/games-analysis/38653-looking-for-chess-software-to-annotate-games.html)

(Process text written for children, as they will be more explicit???)

(OCR My system)
(process text for knowledge using AI)

(the texts should be available from Digilib or Media Library)

(once we have positional theorem proving working, we can do the
 following.  Take a database of positions, some of which are
 known (somehow) to be wins, preferably known via human analysis,
 some of which are known to be other, etc.  In fact, all known
 states, e.g. stands better, with winning chances, etc.  Then for
 each position, do some analysis, and record all the theorems in a
 feature set.  Then perform machine learning to see what are the
 best indicators of a won position.)
