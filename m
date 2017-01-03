Return-Path: <rtc-linux+bncBAABBPFQWDBQKGQEJU6DCUA@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id 75si2567556wme.3.2017.01.03.13.31.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 13:31:40 -0800 (PST)
Date: Tue, 3 Jan 2017 21:31:18 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: Bhumika Goyal <bhumirks@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>,
	Jason Cooper <jason@lakedaemon.net>, andrew@lunn.ch,
	gregory.clement@free-electrons.com, sebastian.hesselbarth@gmail.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
Message-ID: <20170103213118.GM14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
 <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jan 03, 2017 at 01:18:29PM -0800, Kees Cook wrote:
> On Mon, Jan 2, 2017 at 6:06 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Mon, Dec 26, 2016 at 05:01:02PM +0530, Bhumika Goyal wrote:
> >> The object armada38x_rtc_ops of type rtc_class_ops structure is not
> >> modified after getting initialized by armada38x_rtc_probe. Apart from
> >> getting referenced in init it is also passed as an argument to the function
> >> devm_rtc_device_register but this argument is of type const struct
> >> rtc_class_ops *. Therefore add __ro_after_init to its declaration.
> >
> > What I'd prefer here is for the structure to be duplicated, with one
> > copy having the alarm methods and one which does not.  Both can then
> > be made "const" (so placed into the read-only section at link time)
> > and the probe function select between the two.
> >
> > I think that's a cleaner and better solution, even though it's
> > slightly larger.
> >
> > I'm not a fan of __ro_after_init being used where other solutions are
> > possible.
> 
> Can the pointer that points to the struct rtc_class_ops be made ro_after_init?

It's passed into the RTC core code, and probably stored in some dynamically
allocated object, so probably no.  It's the same class of problem as every
file_operations pointer in the kernel, or the thousand other operations
structure pointers that a running kernel has.

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
