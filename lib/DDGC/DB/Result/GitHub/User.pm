package DDGC::DB::Result::GitHub::User;
# ABSTRACT:

use Moose;
use MooseX::NonMoose;
extends 'DDGC::DB::Base::Result';
use DBIx::Class::Candy;
use namespace::autoclean;

table 'github_user';

column id => {
  data_type => 'bigint',
  is_auto_increment => 1,
};
primary_key 'id';

unique_column github_id => {
  data_type => 'bigint',
  is_nullable => 0,
};

column login => {
  data_type => 'text',
  is_nullable => 0,
};

column gravatar_id => {
  data_type => 'text',
  is_nullable => 1,
};

column name => {
  data_type => 'text',
  is_nullable => 1,
};

column company => {
  data_type => 'text',
  is_nullable => 1,
};

column blog => {
  data_type => 'text',
  is_nullable => 1,
};

column location => {
  data_type => 'text',
  is_nullable => 1,
};

column email => {
  data_type => 'text',
  is_nullable => 1,
};

column bio => {
  data_type => 'text',
  is_nullable => 1,
};

column type => {
  data_type => 'text',
  is_nullable => 0,
};

column created_at => {
  data_type => 'timestamp with time zone',
  is_nullable => 0,
};

column updated_at => {
  data_type => 'timestamp with time zone',
  is_nullable => 1,
};

column created => {
  data_type => 'timestamp with time zone',
  set_on_create => 1,
};

column updated => {
  data_type => 'timestamp with time zone',
  set_on_create => 1,
};

column gh_data => {
  data_type => 'text',
  is_nullable => 0,
  serializer_class => 'AnyJSON',
  default_value => '{}',
};

has_many 'github_commits_authored', 'DDGC::DB::Result::GitHub::Commit', 'author_github_user_id', {
  cascade_delete => 1,
};

has_many 'github_commits_committed', 'DDGC::DB::Result::GitHub::Commit', 'committer_github_user_id', {
  cascade_delete => 1,
};

has_many 'github_pulls', 'DDGC::DB::Result::GitHub::Pull', 'github_user_id', {
  cascade_delete => 1,
};

has_many 'github_repos', 'DDGC::DB::Result::GitHub::Repo', 'github_user_id', {
  cascade_delete => 1,
};

has_many 'github_issues', 'DDGC::DB::Result::GitHub::Issue', 'github_user_id', {
  cascade_delete => 1,
};

has_many 'github_issue_events', 'DDGC::DB::Result::GitHub::Issue::Event', 'github_user_id', {
  cascade_delete => 1,
};

no Moose;
__PACKAGE__->meta->make_immutable;
