Return-Path: <rtc-linux+bncBDS7HNEFSALRBUMOU6ZQKGQEZTLIVDA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 204si958wmx.1.2015.12.10.10.41.21
        for <rtc-linux@googlegroups.com>;
        Thu, 10 Dec 2015 10:41:21 -0800 (PST)
Date: Thu, 10 Dec 2015 19:41:19 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Julius Werner <jwerner@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] RTC: RK808: Work around hardware bug on
 November 31st
Message-ID: <20151210184119.GL3515@piout.net>
References: <CAODwPW-ZJ2HwrQohmfMYv2-jH2Ofq-O2H_HPfqYLXXnueVYYnA@mail.gmail.com>
 <1449552115-31256-1-git-send-email-jwerner@chromium.org>
 <CAD=FV=U+SYHVkgP1sAF4h3xmrQBhc7o=KpryAGAXjeYOYnNTcA@mail.gmail.com>
 <CAODwPW9M6gWXpUkT2A3k6jmj7sBzwjmScE+ZSAe209UDnAW6mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAODwPW9M6gWXpUkT2A3k6jmj7sBzwjmScE+ZSAe209UDnAW6mg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Julius, Doug,

On 09/12/2015 at 13:32:52 -0800, Julius Werner wrote :
> > Thinking about all this: these's actually a totally different
> > alternative approach we could take if you wanted.  It would fix S5 and
> > avoid all the anchor stuff, unless I'm crazy.
> >
> > Basically totally give up on the RTC time reflecting reality.  Add a
> > "real time to rk808" and "rk808 time to real time" function.  Always
> > use it when reading from rk808 and always use it when writing to
> > rk808.  Choose 2015 as the "truth" year if you want (or pick another
> > year).  In early 2016 the rk808 always contains 1 day back.  In 2017
> > the rk808 always contains 2 days back.  Etc, etc, etc.
> >
> > The firmware would get confused, but ...
> 
> Well... other than that it's crazy and that I'd have to rewrite the
> whole patch again, I can't come up with a good argument against this.
> In Chromebook firmware the time is only needed for a debug log, so
> we'd probably just be willing to accept it being wrong. If U-Boot ever
> gets RK808 support, they'll probably just copy the Linux driver
> wholesale anyway so they'll conform to the same system.
> 
> So if nobody else raises fundamental objections to this approach, I
> guess I'll get started on another patch version. (Further replies
> below for reference, but most of that stuff would then become moot.)
> 

I'll try to review and evaluate both solution by the end of the week (no
guarantee though).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
