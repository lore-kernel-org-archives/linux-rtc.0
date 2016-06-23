Return-Path: <rtc-linux+bncBDI57DN47YOBBHXIV65QKGQEWUYFHGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com. [209.85.220.170])
        by gmr-mx.google.com with ESMTPS id v190si30928vkf.2.2016.06.23.07.37.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2016 07:37:18 -0700 (PDT)
Received: by mail-qk0-f170.google.com with SMTP id a186so109168001qkf.0
        for <rtc-linux@googlegroups.com>; Thu, 23 Jun 2016 07:37:18 -0700 (PDT)
Date: Thu, 23 Jun 2016 20:07:13 +0530
From: Pratyush Anand <panand@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@kernel.org, alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	prarit@redhat.com, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: [rtc-linux] Re: [PATCH RFC 1/2] rtc/hpet: Factorize hpet_rtc_timer_init()
Message-ID: <20160623143713.GB16398@dhcppc9>
References: <cover.1466484019.git.panand@redhat.com>
 <076fc9f526af98a2ce7e68897378213271d40519.1466484019.git.panand@redhat.com>
 <alpine.DEB.2.11.1606231032380.5839@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <alpine.DEB.2.11.1606231032380.5839@nanos>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Thomas,

On 23/06/2016:10:33:26 AM, Thomas Gleixner wrote:
> On Tue, 21 Jun 2016, Pratyush Anand wrote:
> 
> > This patch factorize hpet_rtc_timer_init(), so that counter can be
> > initialized before irq is registered.
> 
> This changelog is useless. It tells what the patch does, but not WHY this is
> required.

Sorry, I have described the problem in the cover letter which is here [1].
Please, let me know if any further test/debug result you would need.

Thanks for your help!!

~Pratyush

[1] https://lkml.org/lkml/2016/6/21/35

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
