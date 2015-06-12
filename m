Return-Path: <rtc-linux+bncBDS7HNEFSALRBPFB5OVQKGQE6W6J4WI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k10si86718wia.1.2015.06.12.05.29.47
        for <rtc-linux@googlegroups.com>;
        Fri, 12 Jun 2015 05:29:47 -0700 (PDT)
Date: Fri, 12 Jun 2015 14:29:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: pang.xunlei@zte.com.cn
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
	John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
	Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com,
	Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [PATCH v3 1/4] drivers/rtc/pcf8563: Replace
 deprecated rtc_time_to_tm() and rtc_tm_to_time()
Message-ID: <20150612122946.GG3890@piout.net>
References: <1434074652-16054-1-git-send-email-xlpang@126.com>
 <20150612084027.GD3890@piout.net>
 <OFFC6B610F.4108EED3-ON48257E62.0032A044-48257E62.00330C68@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <OFFC6B610F.4108EED3-ON48257E62.0032A044-48257E62.00330C68@zte.com.cn>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12/06/2015 at 17:17:39 +0800, pang.xunlei@zte.com.cn wrote :
> Hi Alexandre,
> 
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote 2015-06-12 
> PM 04:40:27:
> > 
> > Re: [PATCH v3 1/4] drivers/rtc/pcf8563: Replace deprecated 
> > rtc_time_to_tm() and rtc_tm_to_time()
> > 
> > Hi Xunlei,
> > 
> > Just to let you know that your series are usually classified as spam
> > when coming from 126.com. This series in particular didn't make it to
> > the mailing list.
> 
> Seems ok, I can see it in the mailing list now:
> https://lkml.org/lkml/2015/6/11/767
> 

Yeah, but for example it didn't go through the RTC mailing list:
https://groups.google.com/forum/#!forum/rtc-linux so the patch are not
in patchwork.

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
