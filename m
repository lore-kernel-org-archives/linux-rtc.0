Return-Path: <rtc-linux+bncBDS7HNEFSALRBF7AW62QKGQEIU3WV6Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s132si174014wmd.1.2016.01.31.03.29.26
        for <rtc-linux@googlegroups.com>;
        Sun, 31 Jan 2016 03:29:26 -0800 (PST)
Date: Sun, 31 Jan 2016 12:29:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 0/8] rtc: enable adjustment of clock offset
Message-ID: <20160131112926.GH20165@piout.net>
References: <cover.1451928661.git.stillcompiling@gmail.com>
 <3106681.dzRcYkv4oj@diplodocus>
 <20160126160031.GA25597@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160126160031.GA25597@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 26/01/2016 at 17:00:31 +0100, Alexandre Belloni wrote :
> On 26/01/2016 at 06:56:40 -0800, Joshua Clayton wrote :
> > Ping?
> > 
> > On Monday, January 04, 2016 10:31:18 AM Joshua Clayton wrote:
> > > Alexandre,
> > > this is the second version of apatch set to be able to adjust the
> > > clock on a pcf2123, but with a big addition. I am also proposing
> > > a couple of new rtc api functions and a new sysfs file.
> > > 
> > > Patches 1-5 are very much v2 patches that address All of the
> > > concerns you had with v1. It is my hope to get them merged without
> > > too much more trouble.
> > > 
> > The rtc _needs_ patches 1-5 in order to use the clock offset
> > adjustment at all (current upstream code resets it to zero during
> > device probe, so it doesn't survive a reboot)
> > Should I split out patches 1-5 to make them easier to review?
> > 
> 
> The merge widows just closed so I've started to collect a few patches
> since monday. This is a big series and I didn't have time to review
> everything yet.
> 


Patches 1-5 are applied and pushed to rtc-next.


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
