package DDGC::Web::Controller::Roboduck;
# ABSTRACT: RoboDuck web controller class

use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

sub base :Chained('/base') :PathPart('roboduck') :CaptureArgs(0) {
	my ( $self, $c ) = @_;
	my $query = $c->req->param('q');
	if ($query) {
		my ( $answer, $id ) = $c->d->roboduck->tell(
			$query,
			$c->user ? $c->user->username : $c->sessionid
		);
		$c->stash->{answer} = $answer;
	}
}

sub index :Chained('base') :PathPart('') :Args(0) {
	my ( $self, $c ) = @_;
	$c->add_bc('RoboDuck', '');
}

sub json :Chained('base') :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{not_last_url} = 1;
	$c->stash->{x} = {
		answer => $c->stash->{answer},
	};
	$c->forward( $c->view('JSON') );
}

no Moose;
__PACKAGE__->meta->make_immutable;
