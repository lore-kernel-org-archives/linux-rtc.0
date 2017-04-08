Return-Path: <rtc-linux+bncBCVLJ7OQWEPBBYUEUXDQKGQERYSNPYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.zytor.com (terminus.zytor.com. [65.50.211.136])
        by gmr-mx.google.com with ESMTPS id s67si1100866pfs.4.2017.04.08.13.04.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 13:04:50 -0700 (PDT)
Date: Sat, 08 Apr 2017 13:02:28 -0700
In-Reply-To: <20170408175420.26736-1-hdegoede@redhat.com>
References: <20170408175420.26736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [rtc-linux] Re: [PATCH] x86: i8259: export legacy_pic symbol
To: Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
CC: x86@kernel.org, rtc-linux@googlegroups.com,
        alexandre.belloni@free-electrons.com
From: hpa@zytor.com
Message-ID: <FA8D2855-33DF-4D34-ABA8-0E61F64D5194@zytor.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On April 8, 2017 10:54:20 AM PDT, Hans de Goede <hdegoede@redhat.com> wrote:
>The classic PC rtc-coms driver has a workaround for broken ACPI device
>nodes for it which lack an irq resource. This workaround used to
>unconditionally hardcode the irq to 8 in these cases.
>
>This was causing irq conflict problems on systems without a legacy-pic
>so a recent patch added an if (nr_legacy_irqs()) guard to the
>workaround to avoid this irq conflict.
>
>nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
>an undefined symbol error if the rtc-cmos code is build as a module.
>
>This commit exports the legacy_pic symbol to fix this.
>
>Cc: rtc-linux@googlegroups.com
>Cc: alexandre.belloni@free-electrons.com
>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>---
> arch/x86/kernel/i8259.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
>index be22f5a..4e3b8a5 100644
>--- a/arch/x86/kernel/i8259.c
>+++ b/arch/x86/kernel/i8259.c
>@@ -418,6 +418,7 @@ struct legacy_pic default_legacy_pic = {
> };
> 
> struct legacy_pic *legacy_pic = &default_legacy_pic;
>+EXPORT_SYMBOL(legacy_pic);
> 
> static int __init i8259A_init_ops(void)
> {

Should probably be EXPORT_SYMBOL_GPL
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
