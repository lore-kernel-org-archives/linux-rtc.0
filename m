Return-Path: <rtc-linux+bncBAABBNOOWPBQKGQE2TKV7FI@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id h23si5960031wmi.1.2017.01.04.04.14.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 04:14:44 -0800 (PST)
Date: Wed, 4 Jan 2017 12:14:25 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Kees Cook <keescook@chromium.org>, andrew@lunn.ch,
	Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
	a.zummo@towertech.it, LKML <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	gregory.clement@free-electrons.com,
	Bhumika Goyal <bhumirks@gmail.com>, sebastian.hesselbarth@gmail.com
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
Message-ID: <20170104121425.GP14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
 <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
 <20170103213118.GM14217@n2100.armlinux.org.uk>
 <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien>
 <20170104110750.dtu54t74qkuuvkvq@piout.net>
 <alpine.DEB.2.20.1701041242080.3073@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <alpine.DEB.2.20.1701041242080.3073@hadrien>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jan 04, 2017 at 12:43:32PM +0100, Julia Lawall wrote:
> > The question was whether the point to the rtc_class_ops could be made
> > __ro_after_init. And Russell is right, it is pointed to by the ops
> > pointer in a struct rtc_device and that struct is dynamically allocated
> > in rtc_device_register().
> 
> OK, I think it's a terminology issue.  You mean the structure that
> contains the pointer, and not the pointer itself, which is already const.

That statement is really ambiguous, and really doesn't help the cause -
we have several structures here which contain pointers and it's far from
clear which you're talking about:

- The armada38x_rtc_ops and armada38x_rtc_ops_noirq structures contain
  pointers to functions.
- The dynamically allocated struct rtc_device contains an ops pointer,
  which will point at one or other of these two structures.

Now, as soon as we make armada38x_rtc_ops and armada38x_rtc_ops_noirq
const, if the pointer is passed through any function call where the
argument is not also marked const, or is assigned to a pointer that is
not marked const (without an explicit cast), the compiler will complain.
Remember that a const pointer (iow, const void *ptr) is just a hint to
the compiler that "ptr" _may_ point at read-only data, and dereferences
of the pointer are not allowed to write - it's just syntactic checking.

Given that this is stuff we should all know, I'm not quite sure what
people are getting in a tiz over... I'm finding it worrying that I'm
even writing this mail, reviewing this stuff!  _Really_ worried that
Kees even brought it up in the first place - I suspect that came from
a misunderstanding of my suggestion which is why I later provided the
suggestion in patch form.

What I suggested, and what my patch does is:

1. It places both the armada38x_rtc_ops and armada38x_rtc_ops_noirq
   structures into the .rodata section, which will be protected from
   writes by hardware when appropriate kernel options are enabled.

2. The driver does _not_ store a local pointer to this memory at a
   static address which could be subsequently modified (*).

3. The only pointer to this memory is during driver initialisation
   (which may well reside in a CPU register only) before being passed
   to the RTC subsystem.

4. The RTC subsystem dynamically allocates a struct rtc_device
   structure (in rtc_device_register()) where it eventually stores
   this pointer.  This pointer is already marked const.  This structure
   contains read/write data, and can't be marked read-only, just in the
   same way as "struct file" can't be.

The whole __ro_after_init thing is completely irrelevant and a total
distraction at this point - there is nothing that you could add a
__ro_after_init annotation to after my patch in regard of these ops
structures.

* - however, a compiler may decide to store the addresses of these
structures as a literal constant near the function, but with RONX
protection for the .text section, this memory is also read-only, and
so can't be modified.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
