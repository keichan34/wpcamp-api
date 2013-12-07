# WordCamp API

Gathers data from the [WordCamp Central](http://central.wordcamp.org/) [feed](http://central.wordcamp.org/feed/), and provides it in a nice JSON (or JSONP, if you so desire) format.

Includes goodies like banner images, for use in your theme!

There is a companion widget plugin planned, look out for that!

# Contributing

## Hacking

Hack away! PostgreSQL is required, just copy `database.example.yml` to `database.yml` and fill in the relevant settings.

There are a couple rake tasks to get your database primed with the right data. Run:

```
$ bundle exec rake feed_pollers:wordcamp_central:deep
```

To import all WordCamps. Run `rake -T feed_pollers:wordcamp_central` for a list of what you can do.

## Translation

Translations are welcome! Currently, there are only three files you need to do to add your translation.

* Add your language to `config/application.rb`.
	* Look for the line `config.i18n.available_locales = [:en_US, ...]`, and add your locale string here. Keep note of your locale string here; you'll need it later.
* Copy `config/locales/wpcamp.en_US.yml` to `config/locales/wpcamp.[YOUR LOCALE HERE].yml`, and translate the strings in there.
* Copy `app/views/pages/_index_content.en_US.html.slim` to `app/views/pages/_index_content.[YOUR LOCALE HERE].html.slim`, and translate the strings in there. Don't worry about translating the content inside `pre` or `code` -- they're code.

# License

```
WordCamp API.
Copyright (C) 2013 Keitaroh Kobayashi, Naoko Takano.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
