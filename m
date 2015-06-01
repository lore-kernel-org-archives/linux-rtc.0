Return-Path: <rtc-linux+bncBDEKVJM7XAHRB7XLWKVQKGQE75A4D5Q@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.10])
        by gmr-mx.google.com with ESMTPS id gt9si556184wib.2.2015.06.01.12.43.58
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:43:58 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: pang.xunlei@zte.com.cn
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>, Andrew Christian <andrew.christian@hp.com>, CIH <cih@coventive.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Xunlei Pang <pang.xunlei@linaro.org>, Richard Purdie <rpurdie@rpsys.net>, rtc-linux@googlegroups.com, Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [5/5] drivers/rtc/sa1100: Replace deprecated
 rtc_tm_to_time() and rtc_time_to_tm()
Date: Mon, 01 Jun 2015 21:43:22 +0200
Message-ID: <3404495.679z0IaaBp@wuerfel>
In-Reply-To: <OF8AF02B38.A9E97627-ON48257E55.00352B8F-48257E55.0037661B@zte.com.cn>
References: <1429089611-29776-5-git-send-email-xlpang@126.com> <OF1F6D43BC.C38481A0-ON48257E54.004FA90B-48257E54.004FD9D8@LocalDomain> <OF8AF02B38.A9E97627-ON48257E55.00352B8F-48257E55.0037661B@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Saturday 30 May 2015 18:05:10 pang.xunlei@zte.com.cn wrote:
> PangXunLei10110855/user/zte_ltd wrote 2015-05-29 PM 10:32:15:
> > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote 
> > 2015-04-30 AM 07:28:24:
> > > Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time() 
> > > and rtc_time_to_tm()
> > > 
> > > For the same reason that Russell pointed in patch 4/5, this hides that
> > > it doesn't work after 2106-02-07 06:28:16 as the register is still 32
> > > bits.
> > > I would prefer that you return an error in that case.
> > 
> > Thanks for the review, I want to leave the ones like this untouched.
> > 
> 
> To further explain, for the rtc hardware with 32-bit counters, we actually 
> 
> had a solution before: https://lkml.org/lkml/2014/11/27/341
> 
> But seems some guys don't like the solution, so rtc drivers like this one 
> can't be simply changed to use the new-added y2038-safe interfaces.
> 
> Maybe those drivers will still retain the deprecated interfaces until a 
> better solution is proposed.

Note that Alexandre has stepped up as a new maintainer for RTC now,
so whatever he wants is probably the way it should be done.

I think the way that your first approach came out was a bit unfortunate,
because we didn't have agreement on how it should really be done.

IMHO the rtc_time64_to_hw32 and rtc_hw32_to_time64 interfaces were a
good concept, most importantly so we can easily find where the potential
problems are, but the implementation was a bit too ambitious in trying
to fix the underlying issue.

If we want to start this over again, I think a better approach would be
to introduce trivial functions at first, like

time64_t rtc_hw32_to_time64(u32 hwtime)
{
	/* 
	 * this is safe until about 2106, when unsigned u32 seconds from the
	 * 1970 epoch will overflow
	 */
	return (u64)hwtime;
}
EXPORT_SYMBOL_GPL(rtc_hw32_to_time64);

This way, we can fix all the drivers without introducing any possible
ambiguity and later decide how that function should in fact handle the
2106 overflow. Our grandchildren can take care of that if necessary ;-)

	Arnd

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
