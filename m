Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB4XKUPDQKGQEE5BPNEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p144si245283wme.2.2017.04.08.07.36.34
        for <rtc-linux@googlegroups.com>;
        Sat, 08 Apr 2017 07:36:34 -0700 (PDT)
Date: Sat, 8 Apr 2017 16:36:33 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, the.dr.hax@gmail.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: cmos: Do not assume irq 8 for rtc when
 there are no legacy irqs
Message-ID: <20170408143633.jowhj5o6fahbbhwb@piout.net>
References: <20170318134549.28052-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170318134549.28052-1-hdegoede@redhat.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 18/03/2017 at 14:45:49 +0100, Hans de Goede wrote:
> On some systems (e.g. Intel Bay Trail systems) the legacy PIC is not
> used, in this case virq 8 will be a random irq, rather then hw_irq 8
> from the PIC.
> 
> Requesting virq 8 in this case will not help us to get alarm irqs and
> may cause problems for other drivers which actually do need virq 8,
> for example on an Asus Transformer T100TA this leads to:
> 
> [ 28.745155] genirq: Flags mismatch irq 8. 00000088 (mmc0) vs. 00000080 (rtc0)
> <snip oops>
> [ 28.753700] mmc0: Failed to request IRQ 8: -16
> [ 28.975934] sdhci-acpi: probe of 80860F14:01 failed with error -16
> 
> This commit fixes this by making the rtc-cmos driver continue
> without using an irq rather then claiming irq 8 when no irq is
> specified in the pnp-info and there are no legacy-irqs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/rtc/rtc-cmos.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
Applied, thanks.

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
