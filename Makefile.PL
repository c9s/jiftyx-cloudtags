use inc::Module::Install;

name     'JiftyX-CloudTags';
all_from 'lib/JiftyX/CloudTags.pm';
author   'Cornelius <cornelius.howl@gmail.com>';
license  'GPL';

requires    'Jifty' => 0;
requires    'Jifty::DBI' => 0;
build_requires 'Test::More';

auto_install;

WriteAll;

