Return-Path: <rtc-linux+bncBDO5Z5F56QMBBONDTOZQKGQEO4T7ILA@googlegroups.com>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com. [2a00:1450:400c:c09::230])
        by gmr-mx.google.com with ESMTPS id w79si70269wme.2.2015.12.08.04.48.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2015 04:48:56 -0800 (PST)
Received: by mail-wm0-x230.google.com with SMTP id w144so179303620wmw.1
        for <rtc-linux@googlegroups.com>; Tue, 08 Dec 2015 04:48:56 -0800 (PST)
Date: Tue, 8 Dec 2015 12:48:54 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 6/7] efi: runtime-wrapper: get rid of the
 rtc_lock spinlock
Message-ID: <20151208124854.GC2518@codeblueprint.co.uk>
References: <1448967020-20190-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448967020-20190-7-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448967020-20190-7-git-send-email-ard.biesheuvel@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 01 Dec, at 11:50:19AM, Ard Biesheuvel wrote:
> The rtc_lock spinlock aims to serialize access to the CMOS RTC between
> the UEFI firmware and the kernel drivers that use it directly. However,
> x86 is the only arch that performs such direct accesses, and that never
> uses the time related UEFI runtime services. Since no other UEFI enlightened
> architectures have a legcay CMOS RTC anyway, we can remove the rtc_lock
> spinlock entirely.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/runtime-wrappers.c | 32 +++++---------------
>  1 file changed, 8 insertions(+), 24 deletions(-)

Is this really true? It's not possible, for instance, for 32-bit ARM
systems to use the rtc-cmos driver which would access the same
physical device that UEFI would with the GetTime() service?

With the pending 32-bit ARM UEFI support coming, this needs to be
considered carefully.

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
