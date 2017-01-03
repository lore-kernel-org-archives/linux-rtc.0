Return-Path: <rtc-linux+bncBCF5XGNWYQBRBJVKWDBQKGQEB5QZXUQ@googlegroups.com>
Received: from mail-it0-x22e.google.com (mail-it0-x22e.google.com. [2607:f8b0:4001:c0b::22e])
        by gmr-mx.google.com with ESMTPS id j63si6008791ita.1.2017.01.03.13.18.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2017 13:18:30 -0800 (PST)
Received: by mail-it0-x22e.google.com with SMTP id k132so1673514ita.1
        for <rtc-linux@googlegroups.com>; Tue, 03 Jan 2017 13:18:30 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20170102140654.GF14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com> <20170102140654.GF14217@n2100.armlinux.org.uk>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 3 Jan 2017 13:18:29 -0800
Message-ID: <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Bhumika Goyal <bhumirks@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>,
	Jason Cooper <jason@lakedaemon.net>, andrew@lunn.ch, gregory.clement@free-electrons.com,
	sebastian.hesselbarth@gmail.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, rtc-linux@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jan 2, 2017 at 6:06 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Dec 26, 2016 at 05:01:02PM +0530, Bhumika Goyal wrote:
>> The object armada38x_rtc_ops of type rtc_class_ops structure is not
>> modified after getting initialized by armada38x_rtc_probe. Apart from
>> getting referenced in init it is also passed as an argument to the function
>> devm_rtc_device_register but this argument is of type const struct
>> rtc_class_ops *. Therefore add __ro_after_init to its declaration.
>
> What I'd prefer here is for the structure to be duplicated, with one
> copy having the alarm methods and one which does not.  Both can then
> be made "const" (so placed into the read-only section at link time)
> and the probe function select between the two.
>
> I think that's a cleaner and better solution, even though it's
> slightly larger.
>
> I'm not a fan of __ro_after_init being used where other solutions are
> possible.

Can the pointer that points to the struct rtc_class_ops be made ro_after_init?

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
