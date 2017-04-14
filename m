Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBKN7YLDQKGQEV276SHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id x188si75506wmx.0.2017.04.14.03.08.41
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Apr 2017 03:08:41 -0700 (PDT)
Date: Fri, 14 Apr 2017 12:08:21 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] x86: i8259: export legacy_pic symbol
Message-ID: <20170414100821.q5p5zjolq2pzhquv@piout.net>
References: <20170408210327.2713-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170408210327.2713-1-hdegoede@redhat.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/04/2017 at 23:03:27 +0200, Hans de Goede wrote:
> The classic PC rtc-coms driver has a workaround for broken ACPI device
> nodes for it which lack an irq resource. This workaround used to
> unconditionally hardcode the irq to 8 in these cases.
> 
> This was causing irq conflict problems on systems without a legacy-pic
> so a recent patch added an if (nr_legacy_irqs()) guard to the
> workaround to avoid this irq conflict.
> 
> nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
> an undefined symbol error if the rtc-cmos code is build as a module.
> 
> This commit exports the legacy_pic symbol to fix this.
> 
> Cc: rtc-linux@googlegroups.com
> Cc: alexandre.belloni@free-electrons.com
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
> ---
>  arch/x86/kernel/i8259.c | 1 +
>  1 file changed, 1 insertion(+)
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
