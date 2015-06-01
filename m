Return-Path: <rtc-linux+bncBDS7HNEFSALRBD7TWKVQKGQE3FAVT3Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p9si548604wiz.3.2015.06.01.12.59.10
        for <rtc-linux@googlegroups.com>;
        Mon, 01 Jun 2015 12:59:10 -0700 (PDT)
Date: Mon, 1 Jun 2015 21:59:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: pang.xunlei@zte.com.cn, Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Christian <andrew.christian@hp.com>, CIH <cih@coventive.com>,
	John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Xunlei Pang <pang.xunlei@linaro.org>,
	Richard Purdie <rpurdie@rpsys.net>, rtc-linux@googlegroups.com,
	Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [5/5] drivers/rtc/sa1100: Replace deprecated
 rtc_tm_to_time() and rtc_time_to_tm()
Message-ID: <20150601195909.GO4710@piout.net>
References: <1429089611-29776-5-git-send-email-xlpang@126.com>
 <OF1F6D43BC.C38481A0-ON48257E54.004FA90B-48257E54.004FD9D8@LocalDomain>
 <OF8AF02B38.A9E97627-ON48257E55.00352B8F-48257E55.0037661B@zte.com.cn>
 <3404495.679z0IaaBp@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <3404495.679z0IaaBp@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 01/06/2015 at 21:43:22 +0200, Arnd Bergmann wrote :
> Note that Alexandre has stepped up as a new maintainer for RTC now,
> so whatever he wants is probably the way it should be done.
> 

I'm still quite new in that position and I didn't make my mind in a lot
of different topics ;)

> I think the way that your first approach came out was a bit unfortunate,
> because we didn't have agreement on how it should really be done.
> 
> IMHO the rtc_time64_to_hw32 and rtc_hw32_to_time64 interfaces were a
> good concept, most importantly so we can easily find where the potential
> problems are, but the implementation was a bit too ambitious in trying
> to fix the underlying issue.
> 
> If we want to start this over again, I think a better approach would be
> to introduce trivial functions at first, like
> 
> time64_t rtc_hw32_to_time64(u32 hwtime)
> {
> 	/* 
> 	 * this is safe until about 2106, when unsigned u32 seconds from the
> 	 * 1970 epoch will overflow
> 	 */
> 	return (u64)hwtime;
> }
> EXPORT_SYMBOL_GPL(rtc_hw32_to_time64);
> 
> This way, we can fix all the drivers without introducing any possible
> ambiguity and later decide how that function should in fact handle the
> 2106 overflow. Our grandchildren can take care of that if necessary ;-)
> 

We also have RTCs that can only store the year as an integer between 0
and 99. Some of them will definitively not pass 2099, considering that
the can only handle leap days between 2000 and 2099. Also, we have a few
drivers assuming that year >= 70 is in the 19s so they will stop working
correctly in 2070. I think we also have to consider those while trying
to find a solution.

I feel that we still have a bit of time before having to hurry and find
a proper solution ;)

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
