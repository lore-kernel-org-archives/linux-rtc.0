Return-Path: <rtc-linux+bncBDS7HNEFSALRB54LXW3AKGQE6T3LSSY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w10si169134wmw.3.2016.02.25.10.20.39
        for <rtc-linux@googlegroups.com>;
        Thu, 25 Feb 2016 10:20:39 -0800 (PST)
Date: Thu, 25 Feb 2016 19:20:38 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Henderson <joshua.henderson@microchip.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 2/2] rtc: rtc-pic32: Add PIC32 real time
 clock driver
Message-ID: <20160225182038.GJ12073@piout.net>
References: <1456421449-18225-2-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456421449-18225-2-git-send-email-joshua.henderson@microchip.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 25/02/2016 at 10:30:44 -0700, Joshua Henderson wrote :
> This driver adds support for the PIC32 real time clock and calendar
> peripheral:
> 	- reading and setting time
> 	- alarms provided by dedicated IRQ
> 
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
> Changes since v2:
> 	- Fix rework bug causing unecessary retries for gettime.
> 	- Word commit message to be more precise.
> Changes since v1:
> 	- Fix checkpatch.pl --strict issues.
> 	- Fix alpabetical makefile ordering.
> 	- Specify consistent license.
> 	- General formatting cleanup.
> 	- Drop unecessary flags_lock.
> 	- Replace ugly gogo with do while.
> 	- Remove unecessary checks on time when setting alarm.
> 	- Don't initialize the RTC in probe.
> ---
>  drivers/rtc/Kconfig     |   10 ++
>  drivers/rtc/Makefile    |    1 +
>  drivers/rtc/rtc-pic32.c |  411 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/rtc/rtc-pic32.c
> 
Applied, thanks.

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
