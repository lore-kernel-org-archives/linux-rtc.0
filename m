Return-Path: <rtc-linux+bncBAABBF55VHBQKGQEYP6Y6FI@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id e134si4737630wmd.3.2017.01.02.06.07.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 02 Jan 2017 06:07:19 -0800 (PST)
Date: Mon, 2 Jan 2017 14:06:54 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, jason@lakedaemon.net, andrew@lunn.ch,
	gregory.clement@free-electrons.com, sebastian.hesselbarth@gmail.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
Message-ID: <20170102140654.GF14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Dec 26, 2016 at 05:01:02PM +0530, Bhumika Goyal wrote:
> The object armada38x_rtc_ops of type rtc_class_ops structure is not
> modified after getting initialized by armada38x_rtc_probe. Apart from
> getting referenced in init it is also passed as an argument to the function
> devm_rtc_device_register but this argument is of type const struct
> rtc_class_ops *. Therefore add __ro_after_init to its declaration.

What I'd prefer here is for the structure to be duplicated, with one
copy having the alarm methods and one which does not.  Both can then
be made "const" (so placed into the read-only section at link time)
and the probe function select between the two.

I think that's a cleaner and better solution, even though it's
slightly larger.

I'm not a fan of __ro_after_init being used where other solutions are
possible.

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
