Return-Path: <rtc-linux+bncBDKOZ45RYIGRBD5D56VAKGQEGXMNKDQ@googlegroups.com>
Received: from p3plex2out04.prod.phx3.secureserver.net (p3plex2out04.prod.phx3.secureserver.net. [184.168.131.18])
        by gmr-mx.google.com with ESMTP id x12si22227igx.1.2015.05.19.17.13.03
        for <rtc-linux@googlegroups.com>;
        Tue, 19 May 2015 17:13:03 -0700 (PDT)
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>
Subject: [rtc-linux] RE: rtc: ep93xx: Use readl/writel for io
Date: Wed, 20 May 2015 00:13:02 +0000
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D88261F128D@P3PWEX4MB008.ex4.secureserver.net>
References: <201203211055.31653.hartleys@visionengravers.com>
 <20150519203944.GB3338@piout.net>
In-Reply-To: <20150519203944.GB3338@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tuesday, May 19, 2015 1:40 PM, Alexandre Belloni wrote:
> On 21/03/2012 at 10:55:31 -0700, hartleys wrote :
>> Drivers should not be using the __raw_* io accessors.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
> 
>
> Rebased and applied, thanks!

Man. I forgot all about that patch... ;-)

Thanks,
Hartley

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
