# klynch's Emacs Configuration

I do not claim to be the original author of much of this. However, I have taken
the time to construct an extensive yet manageable configuration for the
greatest operating system known to the modern world.

I wish I properly documented everywhere I borrowed from so that I could give
credit where it is clearly due. Since the day I first learned what elisp was, I
was sneaking through others' .emacs files from coworkers and random
homepages. Now, I hope to give back to the Internets, and give credit when I
can.


## Learning

There is always something to learn in Emacs. I believe it is impossible to know
everything that it can do. I would even go so far as to conjecture that Skynet
will never know the full potential of the beast.

It is frustrating to admit it, but there is always something to relearn. No
matter how many cheatsheets I collect or comments I write down, there will
always be something to forget and rediscover (and each time I think find it to
be a lifesaver and that I will always remember it).


### Emacs Documentation

You really aren't going to get more complete than the official documentation.

1. C-h t: Introductory Emacs Tutorial.

2. describe-X function family: There is decent documentation for most of the
official functionality. Use it. Use it often.

3. [The Emacs Manual](http://www.gnu.org/software/emacs/manual/emacs.html)

4. [An Introduction to Emacs Lisp](http://www.gnu.org/software/emacs/emacs-lisp-intro/)

5. [Emacs Lisp Reference Manual](http://www.gnu.org/software/emacs/manual/html_node/elisp/index.html)

### Tutorials / Guides / Other Documentation

1. [EmacsWiki](http://emacswiki.org): Indispensible.

2. Emacs Presentation: http://web.psung.name/emacs/

3. [Xah's Emacs Tutorial](http://xahlee.org/emacs/emacs.html) is fairly concise
and informative.

4. [Magit Tutorial](http://philjackson.github.com/magit/magit.html)


### Cheatsheets

So many cheatsheets... where to begin?

* [Magit Cheatsheet](http://daemianmack.com/magit-cheatsheet.html)
* OrgMode
* TrampMode
* Shell
* EDiff
* Markdown


### Other Dotfiles

* http://www.emacswiki.org/cgi-bin/wiki/JorgenSchaefersEmacsConfig
* http://sites.google.com/site/steveyegge2/my-dot-emacs-file


## Installation

1. Install the latest version of Emacs (preferably from your package
manager). If you have a Mac I prefer MacPorts but that might take too long or
might give you issues. If so, check out what
[EmacsWiki](http://www.emacswiki.org/emacs/EmacsForMacOS) has to say.

2. Rename this directory to `~/.emacs.d` (where `~/` is your home directory).

3. Make sure the files ~/.emacs or ~/.emacs.el do not exist. The default search
order for Emacs is `~/.emacs`, `~/.emacs.el`, and finally `~/.emacs.d/init.el`.

4. Install dependencies: markdown, make, matlab, octave, texlive (latex), gcc,
notify-send / Growl, ruby, python, git, etc. The list is whatever you want it to be
and what you want Emacs to be.

5. Configure the submodules (from the shell):
    git submodule init
    for i in $(git submodule | sed -e 's/.* //'); do
		spath=$(git config -f .gitmodules --get submodule.$i.path)
    surl=$(git config -f .gitmodules --get submodule.$i.url)
    git clone --depth 1 $surl $spath
		done
		git submodule update

6. Configure [ELPA][], the Emacs Lisp Package Archive, from within Emacs by
running `M-x elpa-install`.

7. Modify the file `~/.emacs.d/private-skel.el` with your personal information
and move it to `~/.emacs.d/private.el`.

8. Launch Emacs! Alternative, you can start emacs with the configuration
without changing your configuration files by running

    emacs -q -l ${PATH_TO_REPO}/init.el

from the command line.


## Structure

Describe files:

* `init.el`
* `private.el`
* `config-*`
* `elisp/*`

* `elpa/*` Libraries from are preferred when [ELPA][] available
since dependencies are handled automatically, and the burden to update them is
removed from the user.

## Packages

I grab my elisp files from many sources. There's probably a link in each
individual elisp file, but this should serve as a starting point for many of
the packages.

* __[weblogger.el](https://launchpad.net/weblogger-el)__ is used for weblog
  maintenance via XML-RPC APIs. (Depends on: xml-rpc.el)

* __[xml-rpc.el](https://launchpad.net/xml-rpc-el)__ is an elisp implementation
  of clienside XML-RPC


## Acknowledgements

* Thanks to [technomancy][] for his [emacs-starter-kit][] that I borrowed from.

* J. Blevin's [markdown-mode](http://jblevins.org/projects/markdown-mode/) is
nice for quick documentation.




## Contributing

If you know your way around Emacs, please try out the starter kit as a
replacement for your regular dotfiles for a while. If there's anything you just
can't live without, add it or let me know so I can add it. Take a look at what
happens in init.el to get started.

Also: see the file TODO. Helping submit new libraries to ELPA is the easiest
way to help out. There are two ways you can do this: either take new libraries
and make them ready for ELPA, dropping them in the elpa-to-submit directory or
take files that are already in elpa-to-submit, ensuring all their dependencies
are correctly loaded into ELPA, and sending them to the ELPA maintainer. There
are [details][ELPA-upload] for how ELPA submission works. Grep the project for
TODO for other things.

Files are licensed under the same license as Emacs unless otherwise noted. See
the file COPYING for details. If I am violating the license of someone else's
code, or did not correctly give credit where it is due, please let me know.

The latest version of this is available from [Github][gitlink].

[technomancy]: http://github.com/technomancy/
[emacs-starter-kit]: http://github.com/technomancy/emacs-starter-kit/
[ELPA]: http://tromey.com/elpa/
[ELPA-upload]: http://tromey.com/elpa/upload.html
[gitlink]: http://github.com/klynch/emacs.d/
