Return-Path: <rtc-linux+bncBCF5XGNWYQBRB665WXBQKGQERRX2Q4Q@googlegroups.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com. [2607:f8b0:4001:c06::22d])
        by gmr-mx.google.com with ESMTPS id n197si5437412itn.1.2017.01.04.13.54.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2017 13:54:03 -0800 (PST)
Received: by mail-io0-x22d.google.com with SMTP id d9so464734706ioe.0
        for <rtc-linux@googlegroups.com>; Wed, 04 Jan 2017 13:54:03 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20170104130628.GQ14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk> <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
 <20170103213118.GM14217@n2100.armlinux.org.uk> <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien> <20170104110750.dtu54t74qkuuvkvq@piout.net>
 <alpine.DEB.2.20.1701041242080.3073@hadrien> <20170104121425.GP14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041320140.3073@hadrien> <20170104130628.GQ14217@n2100.armlinux.org.uk>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Jan 2017 13:53:55 -0800
Message-ID: <CAGXu5jLe6RNa6xrefB--w3M+ECRkMMDZWoyAOp5gA1h6W-1vMA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, andrew@lunn.ch,
	Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>, LKML <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, gregory.clement@free-electrons.com,
	Bhumika Goyal <bhumirks@gmail.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jan 4, 2017 at 5:06 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jan 04, 2017 at 01:23:41PM +0100, Julia Lawall wrote:
>> Basically, the strategy of the patch is that one may consider it
>> preferable to duplicate the structure for the different alternatives,
>> rather than use __ro_after_init.  Perhaps if the structure were larger,
>> then __ro_after_init would be a better choice?
>
> It depends on not just the size, but how many members need to be
> modified, and obviously whether there are likely to be more than one
> user of the structure as well.
>
> So I'd say __ro_after_init rarely makes sense for an operations
> structure - the only case I can see is:
>
> - a large structure
> - only a small number of elements need to be modified
> - it is only single-use
>
> which is probably quite rare - this one falls into two out of those
> three.
>
> There's another consideration (imho) too - we may wish, at a later
> date, to make .text and .rodata both read-only from the start of the
> kernel to harden the kernel against possibly init-time exploitation.
> (Think about a buggy built-in driver with emulated hardware - much the
> same problem that Kees is trying to address in one of his recent patch
> sets but with hotplugged hardware while a screen-saver is active.)
> Having function pointers in .rodata rather than the ro-after-init
> section would provide better protection.

Agreed: I'd much prefer things just be const. :) As to my confusing
question, I hadn't looked at how where the pointers to the structure
was being stored, so I was just asking if it, too, could be const,
which it can't, and that's fine here.

-Kees

-- 
Kees Cook
Nexus Security

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
