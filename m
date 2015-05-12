Return-Path: <rtc-linux+bncBDMJX6NV6MPRB6VXY2VAKGQE6DS7MWI@googlegroups.com>
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr. [80.12.242.129])
        by gmr-mx.google.com with ESMTPS id q10si49377wiz.0.2015.05.11.23.21.46
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 23:21:46 -0700 (PDT)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Rob Herring <robh@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,  Alexandre Belloni <alexandre.belloni@free-electrons.com>,  Eric Miao <eric.y.miao@gmail.com>,  Haojian Zhuang <haojian.zhuang@gmail.com>,  Alessandro Zummo <a.zummo@towertech.it>,  rtc-linux@googlegroups.com,  Arnd Bergmann <arnd@arndb.de>,  "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,  Daniel Mack <daniel@zonque.org>
Subject: [rtc-linux] Re: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
	<1431384089-28367-2-git-send-email-robh@kernel.org>
	<20150511224934.GL2067@n2100.arm.linux.org.uk>
	<CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
Date: Tue, 12 May 2015 08:20:52 +0200
In-Reply-To: <CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
	(Rob Herring's message of "Mon, 11 May 2015 19:35:24 -0500")
Message-ID: <87lhgumi4b.fsf@belgarion.home>
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

Rob Herring <robh@kernel.org> writes:

>> This really isn't a good idea - what do you think happens when
>> the same struct resource gets passed into insert_resource()
>> twice?
>
> Bad things. If you recall, we discussed this on v1[1]. See the commit
> msg of patch 2 for the summary. There is not currently a problem
> because the rtc-pxa driver does not request the resource.

I think you're talking about resource claiming, while Russell is talking about
resource declaration.

The point Russell is raising is if you do a platform_add_device() twice with the
same resource (which is done in pxa, once for sa1100-rtc, once for pxa-rtc), you
call insert_resource() twice with the same resource structure.

I had not thought of that before (that's in my reply noted "nasty consequences"
in [1]), and I'll do my homework this week, and try this only patch, but if I
follow Russell's thinking, then sa1100-rtc and pxa-rtc cannot be declared
together anymore.

Cheers.

--
Robert

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
