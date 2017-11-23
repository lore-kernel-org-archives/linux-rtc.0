Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:40044 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdKWHF2 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 23 Nov 2017 02:05:28 -0500
MIME-Version: 1.0
In-Reply-To: <20171121152823.payahwcvnnjervgf@piout.net>
References: <20171121152823.payahwcvnnjervgf@piout.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2017 21:05:27 -1000
Message-ID: <CA+55aFznZnY_1-puQms6jm9nonAooDvTbvUqZjZ8bC0PGboLmg@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 4.15
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Nov 21, 2017 at 5:28 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
>
> The last minute change is only a documentation update to avoid further
> bug reports. (And also a small commit message reword).

This is _really_ annoying.

I'm checking that pull requests have been in linux-next, and that
rewording of the commit message just means that now that  commit
doesn't trigger as being in commit-next and I have to go chase it down
or just say "screw this, it adds a whole new driver that wasn't in
linux-next".

Guess which one is easier for me to do?

So don't do this crap.

I ended up looking up the original commit, but dammit, I'm not happy
about this. Why wasn't the RTC stuff sent last week like I asked
people to do? Now I'm in the middle of travels, and having to figure
out what parts were in linux-next to verify that it actually has
gotten at least some real test coverage, and that I'm not pulling
random stuff.

                Linus
