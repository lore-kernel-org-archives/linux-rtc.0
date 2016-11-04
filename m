Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWNJ6TAAKGQERFJBLPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id g142si626452wmd.2.2016.11.04.16.08.08
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Nov 2016 16:08:08 -0700 (PDT)
Date: Sat, 5 Nov 2016 00:08:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [rtc-linux] Re: [PATCH v3 1/7] rtc: rtc-jz4740: Add support for the
 RTC in the jz4780 SoC
Message-ID: <20161104230808.gulyxjzezczx44jh@piout.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161031203951.5444-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161031203951.5444-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/10/2016 at 21:39:45 +0100, Paul Cercueil wrote :
> The RTC unit present in the JZ4780 works mostly the same as the one in
> the JZ4740. The major difference is that register writes need to be
> explicitly enabled, by writing a magic code (0xA55A) to a "write
> enable" register before each access.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  drivers/rtc/Kconfig      |  6 +++---
>  drivers/rtc/rtc-jz4740.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> v2: No change
> v3: No change
> 

All applied, thanks


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
