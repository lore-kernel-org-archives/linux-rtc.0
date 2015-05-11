Return-Path: <rtc-linux+bncBCUYRNXYZECRBDXEYSVAKGQEPT7AXAA@googlegroups.com>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id m3si1017wia.1.2015.05.11.15.49.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 15:49:47 -0700 (PDT)
Date: Mon, 11 May 2015 23:49:34 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Rob Herring <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>
Subject: [rtc-linux] Re: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
Message-ID: <20150511224934.GL2067@n2100.arm.linux.org.uk>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <1431384089-28367-2-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431384089-28367-2-git-send-email-robh@kernel.org>
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, May 11, 2015 at 05:41:26PM -0500, Rob Herring wrote:
> Add the memory resource for the sa1100-rtc device. Since the memory
> resource is already present in the pxa_rtc_resources, that makes
> sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
> pxa_rtc_resources for both devices and remove the duplicate
> sa1100_rtc_resources.

This really isn't a good idea - what do you think happens when
the same struct resource gets passed into insert_resource()
twice?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

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
