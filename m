Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB7UBY3FAKGQENIMWEHY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f15si271544wmg.2.2017.06.26.14.47.42
        for <rtc-linux@googlegroups.com>;
        Mon, 26 Jun 2017 14:47:42 -0700 (PDT)
Date: Mon, 26 Jun 2017 23:47:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Brian Norris <computersforpeace@gmail.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: brcmstb-waketimer: Add Broadcom
 STB wake-timer
Message-ID: <20170626214741.vmz3froqcmrlyxds@piout.net>
References: <20170626211503.7471-1-f.fainelli@gmail.com>
 <20170626211503.7471-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170626211503.7471-3-f.fainelli@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/06/2017 at 14:15:03 -0700, Florian Fainelli wrote:
> From: Brian Norris <computersforpeace@gmail.com>
> 
> This adds support for the Broadcom STB wake-timer which is a timer in
> the chip's 27Mhz clock domain that offers the ability to wake the system
> (wake-up source) from suspend states (S2, S3, S5). It is supported using
> the rtc framework allowing us to configure alarms for system wake-up.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/rtc/Kconfig                 |  11 ++
>  drivers/rtc/Makefile                |   1 +
>  drivers/rtc/rtc-brcmstb-waketimer.c | 325 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 337 insertions(+)
>  create mode 100644 drivers/rtc/rtc-brcmstb-waketimer.c
> 

Both applied, thanks.

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
