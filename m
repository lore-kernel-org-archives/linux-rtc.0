Return-Path: <rtc-linux+bncBDAMN6NI5EERBUV6V25QKGQEZASAATY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (linutronix.de. [2001:470:1f0b:db:abcd:42:0:1])
        by gmr-mx.google.com with ESMTPS id a186si136234wma.1.2016.06.23.01.35.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 01:35:29 -0700 (PDT)
Date: Thu, 23 Jun 2016 10:33:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pratyush Anand <panand@redhat.com>
cc: mingo@kernel.org, alexandre.belloni@free-electrons.com,
    rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
    prarit@redhat.com, Andy Lutomirski <luto@kernel.org>,
    Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
    Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
    Viresh Kumar <viresh.kumar@linaro.org>,
    "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: [rtc-linux] Re: [PATCH RFC 1/2] rtc/hpet: Factorize hpet_rtc_timer_init()
In-Reply-To: <076fc9f526af98a2ce7e68897378213271d40519.1466484019.git.panand@redhat.com>
Message-ID: <alpine.DEB.2.11.1606231032380.5839@nanos>
References: <cover.1466484019.git.panand@redhat.com> <076fc9f526af98a2ce7e68897378213271d40519.1466484019.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 21 Jun 2016, Pratyush Anand wrote:

> This patch factorize hpet_rtc_timer_init(), so that counter can be
> initialized before irq is registered.

This changelog is useless. It tells what the patch does, but not WHY this is
required.
 
Thanks,

	tglx
