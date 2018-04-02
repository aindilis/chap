CHAP

CHess Analysis Program


This system performs human-like chess analysis.  It reasons about
position and displays the strengths and weaknesses, etc.  It
differs from usual computer chess in that it employs positional
theorem proving and language based reasoning, as opposed to pure
minimax type model-checking, which is deemed too simplistic.

This is a chess theorem proving system. It is based on codifying the
meaning of various chess situations, and then running theorem prover
and AI planning tools on those representations. Also working on
extracting knowledge using natural language understanding over
annotated chess games and books. This is the GUI that allows one to
edit positions, follow games, etc. The GUI is rendered directly from
the FreeKBS2 knowledge base containing the position and other
knowledge.

See these files:

scripts/query-kbs.pl
CHAP/GUI/Tab/Board/Tab/Query.pm

