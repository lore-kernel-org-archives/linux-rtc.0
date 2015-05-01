Return-Path: <rtc-linux+bncBDMJX6NV6MPRBRWOR2VAKGQEWFQT4IY@googlegroups.com>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr. [80.12.242.128])
        by gmr-mx.google.com with ESMTPS id m3si258678wia.1.2015.05.01.09.18.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 May 2015 09:18:14 -0700 (PDT)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>,  Alessandro Zummo <a.zummo@towertech.it>,  linux-arm-kernel@lists.infradead.org,  Arnd Bergmann <arnd@arndb.de>,  Daniel Mack <daniel@zonque.org>,  Haojian Zhuang <haojian.zhuang@gmail.com>,  Eric Miao <eric.y.miao@gmail.com>,  rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/4] ARM: pxa: add memory resource to RTC device
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
	<1430426233-7461-2-git-send-email-robh@kernel.org>
Date: Fri, 01 May 2015 18:17:45 +0200
In-Reply-To: <1430426233-7461-2-git-send-email-robh@kernel.org> (Rob Herring's
	message of "Thu, 30 Apr 2015 15:37:10 -0500")
Message-ID: <87ioccjmqe.fsf@belgarion.home>
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

> Add the memory resource for the sa1100-rtc device. Since the memory
> resource is already present in the pxa_rtc_resources, that makes
> sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
> pxa_rtc_resources for both devices and remove the duplicate
> sa1100_rtc_resources.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> v2:
> - Rebase to v4.1-rc1
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

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
