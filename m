Return-Path: <rtc-linux+bncBDS7HNEFSALRBUPSQO3QKGQEGKIJGRA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c7si56575wmf.2.2016.03.09.20.34.25
        for <rtc-linux@googlegroups.com>;
        Wed, 09 Mar 2016 20:34:25 -0800 (PST)
Date: Thu, 10 Mar 2016 05:34:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
	rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 4/6] parisc: rtc: provide rtc_class_ops directly
Message-ID: <20160310043412.GC9868@piout.net>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-5-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456851608-3374907-5-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/03/2016 at 18:00:00 +0100, Arnd Bergmann wrote :
> -	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
> +					     &rtc_generic_ops,
> +					     sizeof(rtc_generic_ops));
> +
> +

spurious blank line

>  	return PTR_ERR_OR_ZERO(pdev);
>  }
>  device_initcall(rtc_init);
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
