Return-Path: <rtc-linux+bncBDY3NC743AGBBBFW52UAKGQE26QG7DY@googlegroups.com>
Received: from smtprelay.hostedemail.com (smtprelay0093.hostedemail.com. [216.40.44.93])
        by gmr-mx.google.com with ESMTP id bz6si952137wib.3.2015.04.01.00.15.15
        for <rtc-linux@googlegroups.com>;
        Wed, 01 Apr 2015 00:15:16 -0700 (PDT)
Message-ID: <1427872512.31790.3.camel@perches.com>
Subject: Re: [rtc-linux] Re: [PATCH 3/3] rtc: hctosys: use function name in
 the error log
From: Joe Perches <joe@perches.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Aaro Koskinen
	 <aaro.koskinen@iki.fi>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2015 00:15:12 -0700
In-Reply-To: <20150401090520.559ead39@linux.lan.towertech.it>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
	 <1427576976-22353-3-git-send-email-aaro.koskinen@iki.fi>
	 <20150401030124.GO3849@piout.net> <1427858308.18175.30.camel@perches.com>
	 <20150401090520.559ead39@linux.lan.towertech.it>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, 2015-04-01 at 09:05 +0200, Alessandro Zummo wrote:
> On Tue, 31 Mar 2015 20:18:28 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > Neither __func__ or __FILE__ is really useful here.
> > The message is already specific enough without it.
> > 
> > If anything, it'd probably be better to add
> > 
> > #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
>  Seems reasonable given that pr_fmt is widely
>  used elsewhere.
> 
>  I don't like too much the need to have one define for
>  each file, but it's the way it works :-/

True.  Right now.

I've a desire to make a change one day so that's
the default instead of blank.

http://comments.gmane.org/gmane.linux.kernel/1052288

There are some remaining treewide complications
before that can be done effectively though.

A few files will need "#define pr_fmt(fmt) fmt"
so no prefix is used.




-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
