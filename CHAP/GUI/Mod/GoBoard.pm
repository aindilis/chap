package CHAP::GUI::Mod::GoBoard;

use Bard::Util;
use KBS2::Client;
use PerlLib::SwissArmyKnife;

use subs qw/make_bindings move_bbox move_image/;
use Tk::DragDrop;
use Tk::DropSite;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyFrame MyCanvas SquareSize SquareSpacing BoardSize MyClient
   Placement Flags Move /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Flags($args{Flags} || {});
  $self->Move("black");
  #   $self->MyClient
  #     (KBS2::Client->new
  #      (Context => "Org::FRDCSA::CHAP"));
  #   # add a hook to the listen
  #   $UNIVERSAL::chap->MyGUI->ListenHooks->{"GoBoard-KBS2-Client"} =
  #     sub {
  #       $self->MyClient->MyAgent->Listen
  # 	(TimeOut => 0.05);
  #     };
  $self->MyFrame($args{Frame});
  $self->SquareSize($args{SquareSize} || 18);
  $self->SquareSpacing($args{SquareSpacing} || 0);
  $self->BoardSize($self->SquareSize * 19 + $self->SquareSpacing * 20);
  $self->MyCanvas
    ($self->MyFrame->Canvas
     (
      -height => $self->BoardSize,
      -width => $self->BoardSize,
      -scrollregion => [0,0,$self->BoardSize,$self->BoardSize],
      -background => "black",
      -borderwidth => 0,
     ));
  $self->MyCanvas->pack(-side => "right");
  $self->MyFrame->pack();
  # $self->InitDragDrop();

  # load all the images
  foreach my $piece (qw(black white)) {
    $self->MyCanvas->Photo
      (
       $piece,
       -file => "/var/lib/myfrdcsa/codebases/minor/chap/images/go/".$self->SquareSize."/".$piece.".gif",
      );
  }
  $self->Draw;
  $self->MyCanvas->bind
    ($id, '<ButtonPress-1>' =>
     [sub {
	my ($c, $id) = @_;
	($c_dest->{'x' . $id}, $c_dest->{'y' . $id}) =
	  ($Tk::event->x, $Tk::event->y);
	$self->Placement([$Tk::event->x,$Tk::event->y]);
      }, $id]);
  $self->MyCanvas->bind
    ($id, '<ButtonRelease-1>' =>
     [sub {
	my ($c, $id) = @_;
	my ($x, $y) = ($Tk::event->x, $Tk::event->y);
	# get the center coordinates
	# go ahead and get the notation and then the center
	my $startingpoint = $self->GetSquareContainingCoordinates
	  (
	   X => $self->Placement->[0],
	   Y => $self->Placement->[1],
	  );
	if ($startingpoint->{Success}) {
	  my $endingpoint = $self->GetSquareContainingCoordinates
	    (
	     X => $x,
	     Y => $y,
	    );
	  if ($endingpoint->{Success}) {
	    # now we propose the move
	    my $res1 = $self->ProposeMove
	      (
	       From => $startingpoint->{Result}->{Notation},
	       To => $endingpoint->{Result}->{Notation},
	      );
	    # create an icon of the proper color
	    if ($res1->{Success} and $res1->{Result} == 1) {
	      my $id = $self->MyCanvas->createImage
		(
		 $x1 + $self->SquareSize / 2, $y1 + $self->SquareSize / 2,
		 -image => $self->Move(),
		);
	      if ($self->Move eq "black") {
		$self->Move("white");
	      } else {
		$self->Move("black");
	      }
	    }
	  }
	}
      }, $id]);
}

sub Draw {
  my ($self,%args) = @_;
  $self->MyCanvas->Photo
    (
     "square",
     -file => "/var/lib/myfrdcsa/codebases/minor/chap/images/go/".$self->SquareSize."/square.gif",
    );
  foreach my $j (1..19) {
    my $y1 = ($j - 1) * ($self->SquareSize + $self->SquareSpacing) + $self->SquareSpacing;
    foreach my $i (1..19) {
      my $x1 = ($i - 1) * ($self->SquareSize + $self->SquareSpacing) + $self->SquareSpacing;
      my $id = $self->MyCanvas->createImage
	(
	 $x1 + $self->SquareSize / 2, $y1 + $self->SquareSize / 2,
	 -image => "square",
	);
    }
  }
  if (! exists $self->Flags->{Simple}) {
    # $self->Refresh;
  }
}

sub Refresh {
  my ($self,%args) = @_;
  return;
  # query the KBS for the position of all the pieces
  my $message = $self->MyClient->Send
    (
     QueryAgent => 1,
     Query => "(in (on ?PIECE ?SQUARE) pos1)",
     InputType => "KIF String",
     Quiet => 1,
    );
  my $bindings = $message->Data->{Result}->{Bindings}->[0];
  foreach my $binding (@$bindings) {

    my @square = @{$binding->[0]->[1]};
    shift @square;
    my @piece = @{$binding->[1]->[1]};
    shift @piece;
    # print join(" ",@square,@piece)."\n";

    my $piece = join("-",@piece);

    # this involves querying the KB for current position
    # just put a pawn at 0 0
    my $res = $self->ConvertNotationToCoordinates
      (
       Place => "Center",
       Square => \@square,
      );
    if ($res->{Success}) {
      my $x1 = $res->{Result}->{X};
      my $y1 = $res->{Result}->{Y};
      my $id = $self->MyCanvas->createImage
	(
	 $x1 + $self->SquareSize / 2, $y1 + $self->SquareSize / 2,
	 -image => $piece,
	);

      $self->MyCanvas->bind
	($id, '<ButtonPress-1>' =>
	 [sub {
	    my ($c, $id) = @_;
	    ($c_dest->{'x' . $id}, $c_dest->{'y' . $id}) =
	      ($Tk::event->x, $Tk::event->y);
	    $self->Placement([$Tk::event->x,$Tk::event->y]);
	  }, $id]);
      $self->MyCanvas->bind
	($id, '<ButtonRelease-1>' =>
	 [sub {
	    my ($c, $id) = @_;
	    my ($x, $y) = ($Tk::event->x, $Tk::event->y);
	    # get the center coordinates
	    # go ahead and get the notation and then the center
	    my $startingpoint = $self->GetSquareContainingCoordinates
	      (
	       X => $self->Placement->[0],
	       Y => $self->Placement->[1],
	      );
	    if ($startingpoint->{Success}) {
	      my $endingpoint = $self->GetSquareContainingCoordinates
		(
		 X => $x,
		 Y => $y,
		);
	      if ($endingpoint->{Success}) {
		# now we propose the move
		my $res1 = $self->ProposeMove
		  (
		   From => $startingpoint->{Result}->{Notation},
		   To => $endingpoint->{Result}->{Notation},
		  );
		# create an icon of the proper color


		if ($res1->{Success} and $res1->{Result} == 1) {
		  $c->move($id, $endingpoint->{Result}->{CenterX} - $startingpoint->{Result}->{CenterX}, $endingpoint->{Result}->{CenterY} - $startingpoint->{Result}->{CenterY});
		}
	      }
	    }
	  }, $id]);
    }
  }
}

sub GetSquareContainingCoordinates {
  my ($self,%args) = @_;
  my $result = {};
  my ($x,$y) = ($args{X},$args{Y});
  $result->{ClickX} = $x;
  $result->{ClickY} = $y;
  my $res1 = $self->ConvertCoordinatesToNotation
    (
     X => $x,
     Y => $y,
    );
  if ($res1->{Success}) {
    $result->{Notation} = $res1->{Result};
    my $res2 = $self->ConvertNotationToCoordinates
      (
       Square => $res1->{Result},
       Place => "Center",
      );
    if ($res2->{Success}) {
      $result->{CenterX} = $res2->{Result}->{X};
      $result->{CenterY} = $res2->{Result}->{Y};
      return {
	      Success => 1,
	      Result => $result,
	     };
    }
  }
  return {
	  Success => 0,
	 };
}

sub ConvertNotationToCoordinates {
  my ($self,%args) = @_;
  my $i;
  if ($args{Square}->[0] =~ /^[a-z]$/i) {
    $i = Letter2Number(Letter => $args{Square}->[0]) + 1;
  } else {
    $i = $args{Square}->[0];
  }
  my $j = $args{Square}->[1];
  my $x1 = ($i - 1) * ($self->SquareSize + $self->SquareSpacing) + $self->SquareSpacing;
  my $y1 = ($j - 1) * ($self->SquareSize + $self->SquareSpacing) + $self->SquareSpacing;
  if ($args{Place} eq "Top Left") {
    return {
	    Success => 1,
	    Result => {
		       X => $x1,
		       Y => $y1,
		      },
	   };
  } elsif ($args{Place} eq "Center") {
    return {
	    Success => 1,
	    Result => {
		       X => $x1 + ($self->SquareSize / 2),
		       Y => $y1 + ($self->SquareSize / 2),
		      },
	   };
  }
}

sub ConvertCoordinatesToNotation {
  my ($self,%args) = @_;
  foreach my $j (1..19) {
    my $y1 = ($j - 1) * ($self->SquareSize + $self->SquareSpacing) + $self->SquareSpacing;
    foreach my $i (1..19) {
      my $x1 = ($i - 1) * ($self->SquareSize + $self->SquareSpacing) + $self->SquareSpacing;
      if ($args{X} >= $x1 and $args{X} <= $x1 + $self->SquareSize) {
	if ($args{Y} >= $y1 and $args{Y} <= $y1 + $self->SquareSize) {
	  return {
		  Success => 1,
		  Result => [$i,$j],
		 };
	}
      }
    }
  }
  return {
	  Success => 0,
	 };
}

sub GetLocation {
  my ($self,%args) = @_;
  my ($screenx,$screeny) =
    (
     $self->MyCanvas->winfo('pointerx'),
     $self->MyCanvas->winfo('pointery'),
    );
  my $geom = $UNIVERSAL::chap->MyGUI->MyMainWindow->geometry;
  if ($geom =~ /^(\d+)x(\d+)\+(\d+)\+(\d+)$/) {
    my ($wwidth,$wheight,$wxoffset,$wyoffset) = ($1,$2,$3,$4);
    my $y = $screeny - $UNIVERSAL::chap->MyGUI->MyMainWindow->y - $UNIVERSAL::chap->MyGUI->MyCanvas->y;
    my $x = $screenx - $UNIVERSAL::chap->MyGUI->MyMainWindow->x - $UNIVERSAL::chap->MyGUI->MyCanvas->x;
    print "<$x,$y>\n";
    return {
	    Success => 1,
	    Results => {
			X => $x,
			Y => $y,
		       }
	   };
  }
  return {
	  Success => 0,
	 };
}

sub ProposeMove {
  my ($self,%args) = @_;
  # figure out if this is a valid move
  return {
	  Success => 1,
	  Result => 1,
	 };
}

1;
