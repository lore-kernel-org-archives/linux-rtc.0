Return-Path: <rtc-linux+bncBDZJXP7F6YLRB2N7WPBQKGQEVF4PUFI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr. [192.134.164.104])
        by gmr-mx.google.com with ESMTPS id 75si2687158wme.3.2017.01.04.03.43.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2017 03:43:37 -0800 (PST)
Date: Wed, 4 Jan 2017 12:43:32 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
cc: Julia Lawall <julia.lawall@lip6.fr>,
    Russell King - ARM Linux <linux@armlinux.org.uk>,
    Kees Cook <keescook@chromium.org>, andrew@lunn.ch,
    Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
    a.zummo@towertech.it, LKML <linux-kernel@vger.kernel.org>,
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
    gregory.clement@free-electrons.com, Bhumika Goyal <bhumirks@gmail.com>,
    sebastian.hesselbarth@gmail.com
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
In-Reply-To: <20170104110750.dtu54t74qkuuvkvq@piout.net>
Message-ID: <alpine.DEB.2.20.1701041242080.3073@hadrien>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com> <20170102140654.GF14217@n2100.armlinux.org.uk> <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com> <20170103213118.GM14217@n2100.armlinux.org.uk> <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien> <20170104110750.dtu54t74qkuuvkvq@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

> The question was whether the point to the rtc_class_ops could be made
> __ro_after_init. And Russell is right, it is pointed to by the ops
> pointer in a struct rtc_device and that struct is dynamically allocated
> in rtc_device_register().

OK, I think it's a terminology issue.  You mean the structure that
contains the pointer, and not the pointer itself, which is already const.

thanks,
julia

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
