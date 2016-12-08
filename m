Return-Path: <rtc-linux+bncBAABBGODU3BAKGQECKJEQ4A@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id s81si1306496wmf.3.2016.12.08.10.08.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:08:25 -0800 (PST)
Date: Thu, 8 Dec 2016 18:08:14 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: armada38x: Convert to time64_t
Message-ID: <20161208180814.GK14217@n2100.armlinux.org.uk>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-3-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161208171010.29446-3-gregory.clement@free-electrons.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Dec 08, 2016 at 06:10:09PM +0100, Gregory CLEMENT wrote:
> It is one more step to remove the deprecated functions rtc_time_to_tm
> and rtc_tm_to_time.

I fail to see any advantage to this patch, or in fact the y2038 patch
merged into rtc.

Let's first look at the original rtc_time_to_tm():

+void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
+{
+       days = time / 86400;
+       year = 1970 + days / 365;

time is an unsigned long, so is 32-bit or 64-bit.  Let's assume 32-bit.
The maximum value it can have is 2^32-1 - which gives a maximum days
value of 49710 (it always fits in an int or unsigned int as a positive
value on any arch supported by Linux.)

That gives a maximum value of 'year' as 2106.  So, actually
rtc_time_to_tm() doesn't have a y2038 problem, it has a y2106 problem.
So, the commentary in the original commit is actually wrong!


Okay, that aside, let's look at what your patch actually achieves.

Old code to set the time:

	unsigned long time;

	ret = rtc_tm_to_time(tm, &time);
	if (ret)
		goto out;
	/* write time to a 32-bit register */

New code:

	time64_t time;

	time = rtc_tm_to_time64(tm);
	/* write time to a 32-bit register */

I fail to see how this is any kind of improvement, or aids to solve the
y2106 problem (not y2038) here.

A better approach would have been to also provide a rtc_tm_to_time32()
following the function signature of rtc_tm_to_time(), but replacing the
unsigned long pointer with a u32 pointer, and (importantly) making it
fail if the time was unrepresentable as a u32 value.

Why u32 and not time_t?  time_t is a signed value, which suffers from
the y2038 problem.  u32 suffers from a y2106 problem, and is what we
have with the original rtc_tm_to_time() on 32-bit platforms.  So it's
safe _not_ to needlessly chop off a bit there which wasn't done in the
original code.

This would mean that drivers (such as armada38x) which are only capable
of storing a 32-bit time fail gracefully to set times beyond y2106.

The problem as I see it right now is that the y2038 patch which
deprecates rtc_time_to_tm() etc wasn't thought out thoroughly enough,
and is making the situation much worse by pushing the problem in many
drivers in a way that results in it being less visible.

I think this needs to be reconsidered, and it needs a much better
implementation - one which at least tells the user that their hardware
has broken when trying to set the time to something the hardware can't
support.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
