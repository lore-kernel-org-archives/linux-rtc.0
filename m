Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIG2X7DQKGQEWOTCLZQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p10si1221229wmg.1.2017.04.13.14.26.55
        for <rtc-linux@googlegroups.com>;
        Thu, 13 Apr 2017 14:26:55 -0700 (PDT)
Date: Thu, 13 Apr 2017 23:26:45 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2] x86: i8259: export legacy_pic symbol
Message-ID: <20170413212645.ctkfqo6mkbmbosgo@piout.net>
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

Hi,

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

This is kind of a pressing issue as this makes linux-next fail to build
for certain configurations.

I can carry it in my tree with your ack or let you apply it for 4.12.
What would you prefer?

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
> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
> index be22f5a..0bcf43d 100644
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -418,6 +418,7 @@ struct legacy_pic default_legacy_pic = {
>  };
>  
>  struct legacy_pic *legacy_pic = &default_legacy_pic;
> +EXPORT_SYMBOL_GPL(legacy_pic);
>  
>  static int __init i8259A_init_ops(void)
>  {
> -- 
> 2.9.3
> 

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
