package DDGC::DB::Result::GitHub::Pull;
# ABSTRACT:

use Moose;
use MooseX::NonMoose;
extends 'DDGC::DB::Base::Result';
use DBIx::Class::Candy;
use namespace::autoclean;

table 'github_pull';

column id => {
  data_type => 'bigint',
  is_auto_increment => 1,
};
primary_key 'id';

unique_column github_id => {
  data_type => 'bigint',
  is_nullable => 0,
};

column github_repo_id => {
  data_type => 'bigint',
  is_nullable => 0,
};
belongs_to 'github_repo', 'DDGC::DB::Result::GitHub::Repo', 'github_repo_id', {
  on_delete => 'cascade',
};

column github_user_id => {
  data_type => 'bigint',
  is_nullable => 0,
};
belongs_to 'github_user', 'DDGC::DB::Result::GitHub::User', 'github_user_id', {
  on_delete => 'cascade',
};

column title => {
  data_type => 'text',
  is_nullable => 0,
};

column body => {
  data_type => 'text',
  is_nullable => 0,
};

column state => {
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

column closed_at => {
  data_type => 'timestamp with time zone',
  is_nullable => 1,
};

column merged_at => {
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
  set_on_update => 1,
};

column gh_data => {
  data_type => 'text',
  is_nullable => 0,
  serializer_class => 'AnyJSON',
  default_value => '{}',
};

no Moose;
__PACKAGE__->meta->make_immutable;
