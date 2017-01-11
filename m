Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBHS2XBQKGQERT2JQEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d207si1150501wmd.1.2017.01.10.16.15.00
        for <rtc-linux@googlegroups.com>;
        Tue, 10 Jan 2017 16:15:00 -0800 (PST)
Date: Wed, 11 Jan 2017 01:14:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, a.zummo@towertech.it, rtc-linux@googlegroups.com,
	adi-buildroot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: add const to rtc_class_ops structures
Message-ID: <20170111001450.6kmxtinx2n2iyh5o@piout.net>
References: <1483636717-30429-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1483636717-30429-1-git-send-email-bhumirks@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/01/2017 at 22:48:37 +0530, Bhumika Goyal wrote :
> Declare rtc_class_ops structures as const as they are only passed
> as an argument to the function devm_rtc_device_register. This argument
> is of type const struct rtc_class_ops *, so rtc_class_ops structures
> having this property can be declared const.
> Done using Coccinelle:
> 
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct rtc_class_ops i@p = {...};
> 
> @ok1@
> identifier r1.i;
> position p;
> @@
> devm_rtc_device_register(...,&i@p,...)
> 
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct rtc_class_ops i;
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> Compilation was terminated while compiling the .o files for all the 
> changed .c files. Therefore file size details of the .o files 
> could not be obtained.
> 
>  drivers/rtc/rtc-au1xxx.c | 2 +-
>  drivers/rtc/rtc-bfin.c   | 2 +-
>  drivers/rtc/rtc-ls1x.c   | 2 +-
>  drivers/rtc/rtc-sh.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
Applied and squashed in the previous one.

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
