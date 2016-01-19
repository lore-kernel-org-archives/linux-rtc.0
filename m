Return-Path: <rtc-linux+bncBDS7HNEFSALRBPWB7K2AKGQESEBAUAI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v7si441179wmg.3.2016.01.19.12.46.54
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jan 2016 12:46:54 -0800 (PST)
Date: Tue, 19 Jan 2016 21:46:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh@kernel.org>,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: sa1100: detect rcnr overflow with dates
 after 2038
Message-ID: <20160119204653.GY3367@piout.net>
References: <1453165031-29194-1-git-send-email-alexandre.belloni@free-electrons.com>
 <87si1tcol0.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87si1tcol0.fsf@belgarion.home>
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

On 19/01/2016 at 21:16:11 +0100, Robert Jarzmik wrote :
> Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:
> 
> > rcnr will overflow in 2038, detect that overflow when setting the time and
> > get rid of the deprecated rtc_tm_to_time()
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> That's very nice, but doesn't that limitation touch almost all drivers, and
> could benefit from a global solution in rtc_set_time() ?
> 
> What I'm thinking of is a field in rtc_device, a u64 which represents the
> maximal time that can be set (or 0 if no maximum). rtc_set_time() would check
> against that maximum and return -EINVAL.
> 
> For the rtc drivers, upon registration they can modify this value to set up this
> clamp. This will require to set only a value in each driver, which looks more
> robust to me.
> 

Actually, that is something I'm currently working on but it is not ready
yet.


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
