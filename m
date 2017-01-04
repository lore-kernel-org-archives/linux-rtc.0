Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBB5PWPBQKGQETHECPXA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si5205837wmd.3.2017.01.04.03.07.51
        for <rtc-linux@googlegroups.com>;
        Wed, 04 Jan 2017 03:07:51 -0800 (PST)
Date: Wed, 4 Jan 2017 12:07:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>, andrew@lunn.ch,
	Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
	a.zummo@towertech.it, LKML <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	gregory.clement@free-electrons.com,
	Bhumika Goyal <bhumirks@gmail.com>, sebastian.hesselbarth@gmail.com
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
Message-ID: <20170104110750.dtu54t74qkuuvkvq@piout.net>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
 <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
 <20170103213118.GM14217@n2100.armlinux.org.uk>
 <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <alpine.DEB.2.20.1701041155380.3073@hadrien>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/01/2017 at 11:57:00 +0100, Julia Lawall wrote :
> 
> 
> On Tue, 3 Jan 2017, Russell King - ARM Linux wrote:
> 
> > On Tue, Jan 03, 2017 at 09:31:18PM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Jan 03, 2017 at 01:18:29PM -0800, Kees Cook wrote:
> > > > On Mon, Jan 2, 2017 at 6:06 AM, Russell King - ARM Linux
> > > > <linux@armlinux.org.uk> wrote:
> > > > > On Mon, Dec 26, 2016 at 05:01:02PM +0530, Bhumika Goyal wrote:
> > > > >> The object armada38x_rtc_ops of type rtc_class_ops structure is not
> > > > >> modified after getting initialized by armada38x_rtc_probe. Apart from
> > > > >> getting referenced in init it is also passed as an argument to the function
> > > > >> devm_rtc_device_register but this argument is of type const struct
> > > > >> rtc_class_ops *. Therefore add __ro_after_init to its declaration.
> > > > >
> > > > > What I'd prefer here is for the structure to be duplicated, with one
> > > > > copy having the alarm methods and one which does not.  Both can then
> > > > > be made "const" (so placed into the read-only section at link time)
> > > > > and the probe function select between the two.
> > > > >
> > > > > I think that's a cleaner and better solution, even though it's
> > > > > slightly larger.
> > > > >
> > > > > I'm not a fan of __ro_after_init being used where other solutions are
> > > > > possible.
> > > >
> > > > Can the pointer that points to the struct rtc_class_ops be made ro_after_init?
> > >
> > > It's passed into the RTC core code, and probably stored in some dynamically
> > > allocated object, so probably no.  It's the same class of problem as every
> > > file_operations pointer in the kernel, or the thousand other operations
> > > structure pointers that a running kernel has.
> 
> I'm not sure to understand the question and the response.  A quick check
> with grep suggests that most rtc_class_ops pointers are already const.
> There seem to be just some instances in specific drivers that are not.
> 

The question was whether the point to the rtc_class_ops could be made
__ro_after_init. And Russell is right, it is pointed to by the ops
pointer in a struct rtc_device and that struct is dynamically allocated
in rtc_device_register().


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
