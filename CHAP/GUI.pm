package CHAP::GUI;

use CHAP::GUI::TabManager;

use Data::Dumper;
use Time::HiRes qw(usleep);
use Tk qw(DoOneEvent DONT_WAIT);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyTabManager MyMainWindow MyMenu ListenHooks /

  ];

my $continueloop;

sub init {
  my ($self,%args) = @_;
  $self->MyTabManager
    (CHAP::GUI::TabManager->new());
  $self->MyMainWindow
    (MainWindow->new
     (
      -title => "CHess Analysis Program (CHAP)",
      -height => 600,
      -width => 800,
     ));
  $self->MyMenu($self->MyMainWindow->menu);
  # my $menubutton = $menu->Menubutton(-text => "Tabs");
  # $menubutton->checkbutton(-label => "Tabs", -variable => \$open);
  $self->ListenHooks
    ({
      TkMain => sub {
	DoOneEvent();
      },
      CHAPAgent => sub {
	$self->AgentListen
	  (
	   Timeout => 0.05,
	  );
      },
     });
}

sub Execute {
  my ($self,%args) = @_;
  $self->MyTabManager->Execute
    (
     MainWindow => $self->MyMainWindow,
     Flags => $args{Flags},
    );
  $self->MyTabManager->Tabs->{"Board"}->MyBoard->Refresh;
  $self->MyMainLoop(TimeOut => 0.05);
}

sub MyMainLoop {
  my ($self,%args) = @_;
  unless ($inMainLoop) {
    local $inMainLoop = 1;
    $continueloop = 1;
    while ($continueloop) {
      foreach my $key (keys %{$self->ListenHooks}) {
	$self->ListenHooks->{$key}->();
      }
    }
  }
}

sub Listen {
  my ($self,%args) = @_;
  my $count = 0;
  unless ($inMainLoop) {
    local $inMainLoop = 1;
    $continueloop = 1;
    while ($continueloop) {
      DoOneEvent(DONT_WAIT);
      usleep 1000;
      if (0) {
	$self->AgentListen
	  (
	   Timeout => int($args{TimeOut} / 10),
	  );
      }
      ++$count;
      if ($count > 10) {
	$continueloop = 0;
      }
    }
  }
}

sub AgentListen {
  my ($self,%args) = @_;
  if ($UNIVERSAL::agent->RegisteredP) {
    $UNIVERSAL::agent->Listen
      (
       TimeOut => $args{TimeOut} || 0.05,
      );
  }
}

1;
