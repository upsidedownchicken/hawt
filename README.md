# hawt

Hawt is an experiment put together while exploring the
[GitHub v3 API](http://developer.github.com/v3/). I see no reason why
you couldn't use it, but I also take no responsibility for anything
that happens if you do use it.

## Purpose

As I said, hawt is experimental, but it does solve a minor annoyance in
GitHub's UI. The list of watched repositories just isn't very useful to
me, and the news feed is too noisy to compensate.

The watched repos list only shows repository names (slugs, whatever),
and I frequently see several in my list and wonder WTF they are. To
find out, I have to click through.

The list is also only a few items long, and expanding it doesn't stick.
So if I click through on an item that's part of the expanded list, when
I return to the list, it's no longer expanded, and I have to scroll up
and do it all again. (Yes, I could go to my profile, click "View All",
blah blah blah that's not how I use GH. Experiment!)

Minor annoyances to be sure, but I wanted to build something around the
API, and I wanted it to be useful, even if only a bit. So hawt displays
the watched list (30 at a time, with paging) and includes the project
descriptions. That's it.

As an aside, did you know [igrigorik](https://github.com/igrigorik)
is watching 2,680 repos? Wow.

## Usage

Clone it, `bundle install`, `foreman start`. Then go to
http://localhost:5000/ and click "Login". Rock on.

## Plans

Most likely this is where it ends. If I get the urge, I might add a
piece to show recent commits for watched repos. Maybe.

You know what they say about plans.

## Thanks

[peter-murach's](https://github.com/peter-murach)
[github_api](https://github.com/peter-murach/github) gem saved the day
when I needed to add paging. Simple. Just worked.

See the Gemfile for the other awesome gems in use.

## License

Do what you like. See LICENSE.
