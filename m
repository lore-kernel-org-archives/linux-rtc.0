Return-Path: <rtc-linux+bncBD62P6P6EQIJZTPHVICRUBHPSLUQU@googlegroups.com>
Received: from mail-yh0-x229.google.com (mail-yh0-x229.google.com. [2607:f8b0:4002:c01::229])
        by gmr-mx.google.com with ESMTPS id v17si551881yhc.0.2015.05.18.06.18.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 06:18:20 -0700 (PDT)
Received: by mail-yh0-x229.google.com with SMTP id a23so51072830yhd.2
        for <rtc-linux@googlegroups.com>; Mon, 18 May 2015 06:18:20 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <87pp62jdpj.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org> <87pp62jdpj.fsf@belgarion.home>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 May 2015 08:18:00 -0500
Message-ID: <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 0/6] SA1100/PXA RTC clean-up
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 15, 2015 at 6:13 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
>> testing on PXA27x/3xx.
> Hi Rob,
>
> I tested on PXA27x. It works for the boards which used pxa-rtc.
> For the others, their defconfig become broken, because the pxa boards with
> sa1100-rtc do not work anymore. And of course no .config manipulation will fix
> this, because PXA architecture is denied the sa1100-rtc driver.

Ah, I didn't realize there is a mixture of use.

I could just do something like this instead of removing
sa1100_device_rtc registration:

#ifndef CONFIG_RTC_DRV_PXA
       &sa1100_device_rtc,
#else
        &pxa_device_rtc,
#endif

Rob

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
