use inc::Module::Install;

name     'JiftyX-CloudTags';
all_from 'lib/JiftyX/CloudTags.pm';
author   'Cornelius <cornelius.howl@gmail.com>';
license  'GPL';

build_requires 'Test::More';

auto_install;

WriteAll;

